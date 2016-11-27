# -*- coding: utf-8 -*-

'''
    Exodus Add-on
    Copyright (C) 2016 Exodus

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
'''


import re,urllib,urlparse,hashlib,random,string,json,base64

from resources.lib.modules import cleantitle
from resources.lib.modules import client
from resources.lib.modules import cache
from resources.lib.modules import directstream


class source:
    def __init__(self):
        self.domains = ['123movies.to', '123movies.ru', '123movies.is', '123movies.gs']
        self.base_link = 'http://123movies.gs'
        self.search_link = '/ajax/suggest_search'
        self.info_link = '/ajax/movie_load_info/%s'
        self.server_link = '/ajax/get_episodes/%s'
        self.direct_link = '/ajax/v2_load_episode/'
        self.embed_link = '/ajax/load_embed/'
        self.key = 'i6m49vd7shxkn985mhodk'
        self.key2 = 'twz87wwxtp3dqiicks2dfyud213k6yg'
        self.key3 = '7bcq9826avrbi6m4'


    def movie(self, imdb, title, year):
        try:
            t = cleantitle.get(title)

            headers = {'X-Requested-With': 'XMLHttpRequest'}

            query = urllib.urlencode({'keyword': title})

            url = urlparse.urljoin(self.base_link, self.search_link)

            r = client.request(url, post=query, headers=headers)

            r = json.loads(r)['content']
            r = zip(client.parseDOM(r, 'a', ret='href', attrs = {'class': 'ss-title'}), client.parseDOM(r, 'a', attrs = {'class': 'ss-title'}))
            r = [i[0] for i in r if cleantitle.get(t) == cleantitle.get(i[1])][:2]
            r = [(i, re.findall('(\d+)', i)[-1]) for i in r]

            for i in r:
                try:
                    y, q = cache.get(self.onemovies_info, 9000, i[1])
                    if not y == year: raise Exception()
                    return urlparse.urlparse(i[0]).path
                except:
                    pass
        except:
            return


    def tvshow(self, imdb, tvdb, tvshowtitle, year):
        try:
            url = {'imdb': imdb, 'tvdb': tvdb, 'tvshowtitle': tvshowtitle, 'year': year}
            url = urllib.urlencode(url)
            return url
        except:
            return


    def episode(self, url, imdb, tvdb, title, premiered, season, episode):
        try:
            data = urlparse.parse_qs(url)
            data = dict([(i, data[i][0]) if data[i] else (i, '') for i in data])

            t = cleantitle.get(data['tvshowtitle'])
            year = re.findall('(\d{4})', premiered)[0]
            years = [str(year), str(int(year)+1), str(int(year)-1)]
            season = '%01d' % int(season)
            episode = '%01d' % int(episode)

            headers = {'X-Requested-With': 'XMLHttpRequest'}

            query = urllib.urlencode({'keyword': '%s - Season %s' % (data['tvshowtitle'], season)})

            url = urlparse.urljoin(self.base_link, self.search_link)

            r = client.request(url, post=query, headers=headers)

            r = json.loads(r)['content']
            r = zip(client.parseDOM(r, 'a', ret='href', attrs = {'class': 'ss-title'}), client.parseDOM(r, 'a', attrs = {'class': 'ss-title'}))
            r = [(i[0], re.findall('(.+?) - season (\d+)$', i[1].lower())) for i in r]
            r = [(i[0], i[1][0][0], i[1][0][1]) for i in r if len(i[1]) > 0]
            r = [i for i in r if t == cleantitle.get(i[1])]
            r = [i[0] for i in r if season == '%01d' % int(i[2])][:2]
            r = [(i, re.findall('(\d+)', i)[-1]) for i in r]

            for i in r:
                try:
                    y, q = cache.get(self.onemovies_info, 9000, i[1])
                    if not y in years: raise Exception()
                    return urlparse.urlparse(i[0]).path + '?episode=%01d' % int(episode)
                except:
                    pass
        except:
            return


    def onemovies_info(self, url):
        try:
            u = urlparse.urljoin(self.base_link, self.info_link)
            u = client.request(u % url)

            q = client.parseDOM(u, 'div', attrs = {'class': 'jtip-quality'})[0]

            y = client.parseDOM(u, 'div', attrs = {'class': 'jt-info'})
            y = [i.strip() for i in y if i.strip().isdigit() and len(i.strip()) == 4][0]

            return (y, q)
        except:
            return


    def sources(self, url, hostDict, hostprDict):
        try:
            sources = []

            if url == None: return sources

            url = urlparse.urljoin(self.base_link, url)
            url = referer = url.replace('/watching.html', '')

            try: url, episode = re.findall('(.+?)\?episode=(\d*)$', url)[0]
            except: episode = None

            vid_id = re.findall('-(\d+)', url)[-1]

            quality = cache.get(self.onemovies_info, 9000, vid_id)[1].lower()
            if quality == 'cam' or quality == 'ts': quality = 'CAM'
            elif quality == 'hd': quality = 'HD'
            else: quality = 'SD'


            try:
                headers = {'X-Requested-With': 'XMLHttpRequest', 'Referer': url}

                u = urlparse.urljoin(self.base_link, self.server_link % vid_id)

                r = client.request(u, headers=headers)

                r = client.parseDOM(r, 'div', attrs = {'class': 'les-content'})
                r = zip(client.parseDOM(r, 'a', ret='onclick'), client.parseDOM(r, 'a'))
                r = [(i[0], ''.join(re.findall('(\d+)', i[1])[:1])) for i in r]

                if not episode == None:
                    r = [i[0] for i in r if '%01d' % int(i[1]) == episode]
                else:
                    r = [i[0] for i in r]

                r = [re.findall('(\d+),(\d+)', i) for i in r]
                r = [i[0][:2] for i in r if len(i) > 0]

                links = []

                links += [{'source': 'gvideo', 'url': self.direct_link + i[1], 'direct': True} for i in r if 2 <= int(i[0]) <= 11]

                links += [{'source': 'openload.co', 'url': self.embed_link + i[1], 'direct': False} for i in r if i[0] == '14']

                links += [{'source': 'videowood.tv', 'url': self.embed_link + i[1], 'direct': False} for i in r if i[0] == '12']

                head = '|' + urllib.urlencode(headers)

                for i in links: sources.append({'source': i['source'], 'quality': quality, 'provider': 'Onemovies', 'url': urlparse.urljoin(self.base_link, i['url']) + head, 'direct': i['direct'], 'debridonly': False})
            except:
                pass

            return sources
        except:
            return sources


    def resolve(self, url):
        try: headers = dict(urlparse.parse_qsl(url.rsplit('|', 1)[1]))
        except: headers = None

        link = url.split('|')[0]

        try:
            if not self.direct_link in link: raise Exception()

            video_id = headers['Referer'].split('-')[-1].replace('/','')

            episode_id= link.split('/')[-1]

            key_gen = ''.join(random.choice(string.ascii_lowercase + string.digits) for x in range(16))

			################# FIX FROM MUCKY DUCK & XUNITY TALK ################												
            key = '87wwxtp3dqii'
            key2 = '7bcq9826avrbi6m49vd7shxkn985mhod'
            coookie = hashlib.md5(episode_id + key).hexdigest() + '=%s' %key_gen
            a= episode_id + key2
            b= key_gen
            i=b[-1]
            h=b[:-1]
            b=i+h+i+h+i+h
            hash_id = uncensored(a, b)
			################# FIX FROM MUCKY DUCK & XUNITY TALK ################                        
						
            url = self.base_link + '/ajax/v2_get_sources/' + episode_id + '?hash=' + urllib.quote(hash_id)

            headers['Referer'] = headers['Referer']+ '\+' + coookie
            headers['Cookie'] = coookie

            result = client.request(url, headers=headers)
            result = result.replace('\\','')

            url = re.findall('"?file"?\s*:\s*"(.+?)"', result)
            url = [directstream.googletag(i) for i in url]
            url = [i[0] for i in url if len(i) > 0]

            u = []
            try: u += [[i for i in url if i['quality'] == '1080p'][0]]
            except: pass
            try: u += [[i for i in url if i['quality'] == 'HD'][0]]
            except: pass
            try: u += [[i for i in url if i['quality'] == 'SD'][0]]
            except: pass

            url = client.replaceHTMLCodes(u[0]['url'])

            if 'requiressl=yes' in url: url = url.replace('http://', 'https://')
            else: url = url.replace('https://', 'http://')
            return url
        except:
            pass

        try:
            if not self.embed_link in link: raise Exception()

            result = client.request(link, headers=headers)

            url = json.loads(result)['embed_url']
            return url
        except:
            pass

			

def uncensored(a,b):
    n = -1
    fuckme=[]
    justshow=[]
    while True:
        
        if n == len(a)-1:
            break
        n +=1
       
        d = int(''.join(str(ord(c)) for c in a[n]))
      
        e=int(''.join(str(ord(c)) for c in b[n]))
        justshow.append(d+e)
        fuckme.append(chr(d+e))
    
    return base64.b64encode(''.join(fuckme))
