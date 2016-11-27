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


import re,urllib,urlparse,json,time

from resources.lib.modules import cleantitle
from resources.lib.modules import client
from resources.lib.modules import directstream


class source:
    def __init__(self):
        self.domains = ['xmovies8.tv', 'xmovies8.ru']
        self.base_link = 'http://xmovies8.ru'
        self.search_link = '/movies/search?s=%s'


    def movie(self, imdb, title, year):
        try:
            query = urlparse.urljoin(self.base_link, self.search_link)
            query = query % urllib.quote_plus(title)

            for i in range(5):
                r = client.request(query)
                if not r == None: break

            t = cleantitle.get(title)

            r = client.parseDOM(r, 'div', attrs = {'class': 'col-lg.+?'})
            r = [(client.parseDOM(i, 'a', ret='href'), client.parseDOM(i, 'a', ret='title')) for i in r]
            r = [(i[0][0], i[1][0]) for i in r if len(i[0]) > 0 and len(i[1]) > 0]
            r = [(i[0], i[1], re.findall('(\d{4})', i[1])) for i in r]
            r = [(i[0], i[1], i[2][-1]) for i in r if len(i[2]) > 0]
            r = [i[0] for i in r if t == cleantitle.get(i[1]) and year == i[2]][0]

            url = re.findall('(?://.+?|)(/.+)', r)[0]
            url = client.replaceHTMLCodes(url)
            url = url.encode('utf-8')
            url = urlparse.urljoin(self.base_link, url)
            url = url.replace('watching.html', '') 
            if not 'watching.html' in url: url = url + 'watching.html'
            return url
        except:
            pass


    def tvshow(self, imdb, tvdb, tvshowtitle, year):
        try:
            url = {'tvshowtitle': tvshowtitle, 'year': year}
            url = urllib.urlencode(url)
            return url
        except:
            return			


    def episode(self, url, imdb, tvdb, title, premiered, season, episode):
        try:
			
			data = urlparse.parse_qs(url)
			data = dict([(i, data[i][0]) if data[i] else (i, '') for i in data])
			title = data['tvshowtitle'] if 'tvshowtitle' in data else data['title']
			title = cleantitle.getsearch(title)
			cleanmovie = cleantitle.get(title)
			data['season'], data['episode'] = season, episode

			seasoncheck = 'season+%s' % (int(data['season']))
			seasonclean = 'season%s' % (int(data['season']))
			episodecheck = 'episode ' + episode

			query = 'http://xmovies8.ru/movies/search?s=%s+%s' % (urllib.quote_plus(title),seasoncheck)
			slink = client.request(query)
			r = client.parseDOM(slink, 'div', attrs = {'class': 'col-lg.+?'})
			r = [(client.parseDOM(i, 'a', ret='href'), client.parseDOM(i, 'a', ret='title')) for i in r]
			r = [(i[0][0], i[1][0]) for i in r if len(i[0]) > 0 and len(i[1]) > 0]
          
			r = [i[0] for i in r if cleanmovie in cleantitle.get(i[1]) and seasonclean in cleantitle.get(i[1])][0]
			url = re.findall('(?://.+?|)(/.+)', r)[0]
			url = client.replaceHTMLCodes(url)
			url = url.encode('utf-8')
			url = urlparse.urljoin(self.base_link, url)
			url = url.replace('watching.html', '') 
			if not 'watching.html' in url: url = url + 'watching.html'
			url = client.request(url, output="geturl")
			if not 'watching.html' in url: url = url + 'watching.html'
			link = client.request(url)
			for item in client.parseDOM(link, 'div', attrs = {'class': 'ep_link full'}):
				match = re.compile('<a href="(.*?)" class="">(.*?)</a>').findall(item)
				match2 = re.compile('<a href="(.*?)" class=".*?">(.*?)</a>').findall(item)
				for url,episodes in match + match2:
					episodes = episodes.lower()
					if episodecheck == episodes:
						if not "http:" in url:
							url = "http:" + url
							url = client.replaceHTMLCodes(url)
							url = url.encode('utf-8')							
							return url
        except:
            return


    def sources(self, url, hostDict, hostprDict):
        try:
            sources = []
			
            if url == None: return sources
            r = url
            referer = url
            for i in range(5):
                post = client.request(r)
                if not post == None: break
            post = re.search("data\s*:\s*{\s*id:\s*(\d+),\s*episode_id:\s*(\d+),\s*link_id:\s*(\d+)", post)
            if post:
				show_id, ep_id, link_id = post.groups()
				post = urllib.urlencode({'id': show_id, 'episode_id': ep_id, 'link_id': link_id, '_': int(time.time() * 1000)})

            headers = {
            'Accept-Formating': 'application/json, text/javascript',
            'X-Requested-With': 'XMLHttpRequest',
            'Server': 'cloudflare-nginx',
            'Referer':referer}

            url = urlparse.urljoin(self.base_link, '/ajax/movie/load_episodes')

            for i in range(5):
                r = client.request(url, post=post, headers=headers)
                if not r == None: break

            r = re.findall("load_player\(\s*'([^']+)'\s*,\s*'?(\d+)\s*'?", r)
            r = list(set(r))
            r = [i for i in r if i[1] == '0' or int(i[1]) >= 720]


            links = []

            for p in r:
                try:
                    				
                    play = urlparse.urljoin(self.base_link, '/ajax/movie/load_player_v2')

                    post = urllib.urlencode({'id': p[0], 'quality': p[1], '_': int(time.time() * 1000)})

                    for i in range(5):
                        url = client.request(play, post=post, headers=headers)
                        if not url == None: break

                    url = json.loads(url)['link']

                    url = client.request(url, headers=headers, output='geturl')


                    if 'openload.' in url:
                        links += [{'source': 'openload.co', 'url': url, 'quality': 'HD', 'direct': False}]

                    #elif 'videomega.' in url:
                        #links += [{'source': 'videomega.tv', 'url': url, 'quality': 'HD', 'direct': False}]

                    else:
                        try: links.append({'source': 'gvideo', 'url': url, 'quality': directstream.googletag(url)[0]['quality'], 'direct': True})
                        except: pass

                except:
                    pass

            for i in links: sources.append({'source': i['source'], 'quality': i['quality'], 'provider': 'Xmovies', 'url': i['url'], 'direct': i['direct'], 'debridonly': False})

            return sources
        except:
            return sources


    def resolve(self, url):
        try:
            url = client.request(url, output='geturl')
            if 'requiressl=yes' in url: url = url.replace('http://', 'https://')
            else: url = url.replace('https://', 'http://')
            return url
        except:
            return


