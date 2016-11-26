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


import re,urllib,urlparse,random

from resources.lib.modules import cleantitle
from resources.lib.modules import client


class source:
    def __init__(self):
        self.domains = ['hdmovie14.net']
        self.base_link = 'http://hdmovie14.net'
        self.search_link = '/search?key=%s+%s'


    def movie(self, imdb, title, year):
        self.url = []	
        try:
					
			self.url = []
			title = cleantitle.getsearch(title)
			cleanmovie = cleantitle.get(title)
			query = self.search_link % (urllib.quote_plus(title),year)
			query = urlparse.urljoin(self.base_link, query)
			# print ('MOVIES14 query',query)
			link = client.request(query)
			r = client.parseDOM(link, 'div', attrs = {'class': 'thumbnail'})
			r = [(client.parseDOM(i, 'a', ret='href'), client.parseDOM(i, 'a', ret='title')) for i in r]
			# print ('MOVIES14 r1',r)
			r = [(i[0][0], i[1][0]) for i in r if len(i[0]) > 0 and len(i[1]) > 0]
			# print ('MOVIES14 r2',r)
			results = [i for i in r if cleanmovie in cleantitle.get(i[0]) and year in i[0]]
			for i in results:
				url = i[0]
				url = client.replaceHTMLCodes(url)
				# print ('MOVIES14 url',url)
				url = url.encode('utf-8')
				url = urlparse.urljoin(self.base_link, url)		
				# print ('MOVIES14 final url',url)
				return url
        except:
            return


    def sources(self, url, hostDict, hostprDict):
        try:
				sources = []
				if url == None: return sources
				link = client.request(url)
				for frame in client.parseDOM(link, 'div', attrs = {'class': 'player_wraper'}):
					iframe_url = client.parseDOM(frame, 'iframe', ret='src')
					if iframe_url:
						url = urlparse.urljoin(self.base_link, iframe_url[0])
						html = client.request(url)
						match = re.compile('"(?:url|src)"\s*:\s*"([^"]+)[^}]+"res"\s*:\s*([^,]+)').findall(html)
						for url, res in match:
							if "1080" in res: quality = "1080p"
							elif "720" in res: quality = "HD"
							else: quality = "SD"
							url = client.replaceHTMLCodes(url)
							url = url.encode('utf-8')
							sources.append({'source': 'gvideo', 'quality': quality, 'provider': 'Movies14', 'url': url, 'direct': True, 'debridonly': False})
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
