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


import re,urllib,urlparse

from resources.lib.modules import cleantitle
from resources.lib.modules import client
from resources.lib.modules import directstream
from resources.lib.modules import jsunpack


class source:
    def __init__(self):
        self.domains = ['moviego.cc']
        self.base_link = 'http://moviego.cc'
        self.search_link = '/index.php?do=search&subaction=search&full_search=1&result_from=1&showposts=1&story=%s+%s'
        self.get_link = '/engine/ajax/getlink.php?id=%s'


    def movie(self, imdb, title, year):
        try:
			query = self.search_link % (urllib.quote_plus(title), year)
			query = urlparse.urljoin(self.base_link, query)

			t = cleantitle.get(title)

			r = client.request(query)

			r = client.parseDOM(r, 'div', attrs = {'class': 'short.+?'})
			r = [(client.parseDOM(i, 'a', ret='href'), client.parseDOM(i, 'a', ret='title')) for i in r]
			r = [(i[0][0], i[1][0]) for i in r if i[0] and i[1]]
			r = [(i[0], re.findall('(.+?) \((\d{4})', i[1])) for i in r]
			r = [(i[0], i[1][0][0], i[1][0][1]) for i in r if i[1]]
			r = [i[0] for i in r if t == cleantitle.get(i[1]) and year == i[2]][0]

			url = re.findall('(?://.+?|)(/.+)', r)[0]
			url = client.replaceHTMLCodes(url)
			url = url.encode('utf-8')
			return url
        except:
            return


    def sources(self, url, hostDict, hostprDict):
        try:
			sources = []

			if url == None: return sources

			url = urlparse.urljoin(self.base_link, url)

			r = client.request(url)

			quality = client.parseDOM(r, 'div', attrs = {'class': 'poster-qulabel'})[0]
			quality = quality.lower()
			if 'cam' in quality or 'ts' in quality: raise Exception()


			ref = client.parseDOM(r, 'iframe', ret='src')[0]

			r = client.request(ref, referer=url)

			s = re.compile('<script>(.+?)</script>', re.DOTALL).findall(r)

			for i in s:
			    try: r += jsunpack.unpack(i)
			    except: pass

			streams = client.parseDOM(r, 'source', ret='src')

			links = client.parseDOM(r, 'li', ret='onclick')
			links = [re.findall('\'(.+?\d+)', i) for i in links]
			links = [i[0] for i in links if i]

			for link in links:
			    try:
			        link = ref + "?source=%s" % link

			        r = client.request(link, referer=link)
			        s = re.compile('<script>(.+?)</script>', re.DOTALL).findall(r)
			        for i in s:
						try: r += jsunpack.unpack(i)
						except: pass

			        streams += client.parseDOM(r, 'source', ret='src')
			    except:
			        pass

			streams = [x for y,x in enumerate(streams) if x not in streams[:y]]

			for i in streams:
			    try: sources.append({'source': 'gvideo', 'quality': directstream.googletag(i)[0]['quality'], 'provider': 'Moviego', 'url': i, 'direct': True, 'debridonly': False})
			    except: pass

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


