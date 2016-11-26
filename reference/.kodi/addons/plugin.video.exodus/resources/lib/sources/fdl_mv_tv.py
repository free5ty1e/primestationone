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
        self.domains = ['1fardadownload.net']
        self.base_link = 'http://www.1fardadownload.net'
        self.series_link = 'http://dl.uplodin.ir'
        self.search_link = '/?blogs=1%2C5&s='


    def movie(self, imdb, title, year):
        self.url = []	
        try:
			self.url = []
			title = cleantitle.getsearch(title)
			# print ("FDL MOVIES", title)
			cleanmovie = cleantitle.get(title)
			query = "%s+%s" % (urllib.quote_plus(title),year)
			query = self.search_link + query
			query = urlparse.urljoin(self.base_link, query)
			# print ("FDL MOVIES", query)
			mylink = client.request(query)
			match = re.compile('<h1><a href="(.*?)" rel="bookmark" title=".*?">(.*?)</a></h1>').findall(mylink)
			for movielink,title in match:
				if year in title:
					title = cleantitle.get(title)
					if cleanmovie in title:
						# print ("FDL MOVIES", movielink)
						self.url.append([movielink,title])
			return self.url
        except:
            return
			
			
    def tvshow(self, imdb, tvdb, tvshowtitle, year):
        try:
            url = {'tvshowtitle': tvshowtitle, 'year': year}
            url = urllib.urlencode(url)
            return url
        except:
            return			

    def episode(self, url, imdb, tvdb, title, premiered, season, episode):
        self.url = []		
        try:
            self.url = []
            data = urlparse.parse_qs(url)
            data = dict([(i, data[i][0]) if data[i] else (i, '') for i in data])
            title = data['tvshowtitle'] if 'tvshowtitle' in data else data['title']

            cleanmovie = cleantitle.get(title)


            season = '%02d' % int(season)
            episode = '%02d' % int(episode)
            checkepisode = "s" + season + "e" + episode
            query = "/Serial/"
            # print("FDL EPISODES", query)
            query = self.series_link + query
            link = client.request(query)
            r = client.parseDOM(link, 'a', ret = 'href')
            for items in r:
				try:
					items = items.encode('utf-8')
					items_clean = urllib.unquote(items)
					# print("FDL EPISODES", items)
					if cleanmovie in cleantitle.get(items_clean):
						# print("FDL EPISODES", items)
						seasonquery = "S%s/" % season
						items = items.replace(' ','%20')
						finalquery = query + items + seasonquery
						# print("FDL EPISODES", finalquery)

						link2 = client.request(finalquery)
						r2 = client.parseDOM(link2, 'a', ret = 'href')
						for links in r2:
							vid_url = links.encode('utf-8')
							if checkepisode in cleantitle.get(vid_url):
								movielink = finalquery + vid_url
								title = vid_url + "=episode"
								self.url.append([movielink,title])
				except:
					pass

            return self.url
        except:
            return		
			

    def sources(self, url, hostDict, hostprDict):
        try:
			sources = []

			for movielink,title in url:

				if not "=episode" in title:
					mylink = client.request(movielink)
					match = re.compile('<a rel="nofollow" href="(.+?)">').findall(mylink)
					for url in match:
						if "1080" in url: quality = "1080p"
						elif "720" in url: quality = "HD"				
						else: quality = "SD"
						url = client.replaceHTMLCodes(url)
						url = url.encode('utf-8')							
						sources.append({'source': 'cdn', 'quality': quality, 'provider': 'Fdl', 'url': url, 'direct': True, 'debridonly': False})

				elif "=episode" in title:
						if "1080" in title: quality = "1080p"
						elif "720" in title: quality = "HD"				
						else: quality = "SD"
						url = movielink
						url = client.replaceHTMLCodes(url)
						url = url.encode('utf-8')							
						sources.append({'source': 'cdn', 'quality': quality, 'provider': 'Fdl', 'url': url, 'direct': False, 'debridonly': False})

			sources = [i for i in sources if i['url'].split('?')[0].split('&')[0].split('|')[0].rsplit('.')[-1].replace('/', '').lower() in ['avi','mkv','mov','mp4','xvid','divx']]

			return sources
        except:
            return sources


    def resolve(self, url):
        try:
            content = client.request(url, output='headers')['Content-Type']
            if not 'html' in content: return url
        except:
            return


