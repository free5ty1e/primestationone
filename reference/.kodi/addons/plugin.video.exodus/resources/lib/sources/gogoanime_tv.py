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


import re,urllib,urlparse,base64

from resources.lib.modules import cleantitle
from resources.lib.modules import client
from resources.lib.modules import directstream


class source:
    def __init__(self):
        self.domains = ['gogoanimemobile.com', 'gogoanimemobile.net', 'gogoanime.io']
        self.base_link = 'http://gogoanimemobile.net'
        self.fullbase_link = 'http://gogoanime.io'
        self.search_link = '/search.html?keyword=%s'
        self.episode_link = '/%s-episode-%s'


    def tvshow(self, imdb, tvdb, tvshowtitle, year):
        try:
            meta = 'http://www.imdb.com/title/%s/' % imdb
            meta = client.request(meta)

            genre = re.findall('href\s*=\s*[\'|\"](.+?)[\'|\"]', meta)
            genre = [i for i in genre if '/genre/' in i]
            genre = [i.split('/genre/')[-1].split('?')[0].lower() for i in genre]
            if not 'animation' in genre: raise Exception()

            t = [tvshowtitle.strip()]

            t2 = client.parseDOM(meta, 'title')
            if t2: t += [re.sub('\((?:.+?|)\d{4}.+', '', t2[0]).strip()]

            t3 = client.parseDOM(meta, 'div', attrs = {'class': 'originalTitle'})
            if t3: t += [re.sub('<.+?>|\(.+?\)', '', t3[0]).strip()]

            t = [x for y,x in enumerate(t) if x not in t[:y]][:2]

            for title in t:
                try:
                    q = urlparse.urljoin(self.base_link, self.search_link)
                    q = q % urllib.quote_plus(title)

                    r = client.request(q, mobile=True)

                    r = client.parseDOM(r, 'div', attrs={'class': 'last_episodes.+?'})
                    r = [(client.parseDOM(i, 'a', ret='href'), client.parseDOM(i, 'a', ret='title'), re.findall('\d{4}', i)) for i in r]
                    r = [(i[0][0], i[1][0], i[2][-1]) for i in r if len(i[0]) > 0 and len(i[1]) > 0 and len(i[2]) > 0]
                    r = [i for i in r if cleantitle.get(title) == cleantitle.get(i[1]) and year == i[2]]

                    if r: url = r[0][0] ; break
                except:
                    pass

            url = re.findall('(?://.+?|)(/.+)', url)[0]
            url = client.replaceHTMLCodes(url)
            url = url.encode('utf-8')
            return url
        except:
            return


    def episode(self, url, imdb, tvdb, title, premiered, season, episode):
        try:
            if url == None: return

            num = base64.b64decode('aHR0cDovL3RoZXR2ZGIuY29tL2FwaS8xRDYyRjJGOTAwMzBDNDQ0L3Nlcmllcy8lcy9kZWZhdWx0LyUwMWQvJTAxZA==')
            num = num % (tvdb, int(season), int(episode))
            num = client.request(num)
            num = client.parseDOM(num, 'absolute_number')[0]

            url = [i for i in url.split('/') if not i == ''][-1]
            url = self.episode_link % (url, num)
            return url
        except:
            return


    def sources(self, url, hostDict, hostprDict):
        try:
            sources = []

            if url == None: return sources

            url = urlparse.urljoin(self.base_link, url)

            r = client.request(url, mobile=True)

            r = client.parseDOM(r, 'iframe', ret='src')

            for u in r:
                try:
                    if not u.startswith('http') and not 'vidstreaming' in u: raise Exception()

                    url = client.request(u)
                    url = client.parseDOM(url, 'source', ret='src')

                    for i in url:
                        try: sources.append({'source': 'gvideo', 'quality': directstream.googletag(i)[0]['quality'], 'provider': 'GoGoAnime', 'url': i, 'direct': True, 'debridonly': False})
                        except: pass
                except:
                    pass

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


