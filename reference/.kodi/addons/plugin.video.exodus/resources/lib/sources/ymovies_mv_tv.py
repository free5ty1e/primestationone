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

from resources.lib.modules import control
from resources.lib.modules import cleantitle
from resources.lib.modules import client


class source:
    def __init__(self):
        self.domains = ['yesmovies.to']
        self.base_link = 'http://yesmovies.to'
        self.info_link = 'http://yesmovies.to/'
        self.playlist = '/ajax/v2_get_sources/%s.html?hash=%s'
        self.key1 = base64.b64decode('eHdoMzhpZjM5dWN4')
        self.key2 = base64.b64decode('OHFoZm05b3lxMXV4')
        self.key = base64.b64decode('Y3RpdzR6bHJuMDl0YXU3a3F2YzE1M3Vv')


    def movie(self, imdb, title, year):
        self.url = []	
        try:
			self.url = []
			title = cleantitle.getsearch(title)
			cleanmovie = cleantitle.get(title)
			query = "/search/%s.html" % (urllib.quote_plus(title))
			query = urlparse.urljoin(self.base_link, query)
			link = client.request(query)
			r = client.parseDOM(link, 'div', attrs = {'class': 'ml-item'})
			for links in r:
				url = client.parseDOM(links, 'a', ret='href')[0]
				title = client.parseDOM(links, 'a', ret='title')[0]
				# url = urlparse.urljoin(self.info_link, url)
				infolink = client.request(url)
				match_year = re.search('<strong>Release:</strong>\s+(\d{4})</p>', infolink)
				match_year = match_year.group(1)
				if year in match_year:
					playurl = re.findall('<a class="mod-btn mod-btn-watch" href="([^"]+)"', infolink)[0]
					playurl = playurl.encode('utf-8')
					referer = "%s" % playurl
					mylink = client.request(referer)
					i_d = re.findall(r'id: "(.*?)"', mylink, re.I|re.DOTALL)[0]
					server = re.findall(r'server: "(.*?)"', mylink, re.I|re.DOTALL)[0]
					type = re.findall(r'type: "(.*?)"', mylink, re.I|re.DOTALL)[0]
					episode_id = re.findall(r'episode_id: "(.*?)"', mylink, re.I|re.DOTALL)[0]
					token = self.__get_token()
					cookies = '%s%s%s=%s' % (self.key1, episode_id, self.key2,token)
					url_hash = urllib.quote(self.__uncensored(episode_id + self.key, token))
					url = urlparse.urljoin(self.base_link, self.playlist % (episode_id, url_hash))						

					request_url = url
					self.url.append([request_url,cookies,referer])
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
			headers = {}
			data = urlparse.parse_qs(url)
			data = dict([(i, data[i][0]) if data[i] else (i, '') for i in data])
			title = data['tvshowtitle'] if 'tvshowtitle' in data else data['title']
			year = data['year'] 
			title = cleantitle.getsearch(title)
			cleanmovie = cleantitle.get(title)
			data['season'], data['episode'] = season, episode
			seasoncheck = "season%s" % season
			checktitle = cleanmovie + seasoncheck
			self.url = []
			showlist = []
			query = "/search/%s.html" % (urllib.quote_plus(title))
			query = urlparse.urljoin(self.base_link, query)
			link = client.request(query)
			r = client.parseDOM(link, 'div', attrs = {'class': 'ml-item'})
			for links in r:
				season_url = client.parseDOM(links, 'a', ret='href')[0]
				title = client.parseDOM(links, 'a', ret='title')[0]
				title = title.encode('utf-8')
				season_url = season_url.encode('utf-8')
				title = cleantitle.get(title)
				if checktitle in title:
						showlist.append(season_url)
								
			for seasonlist in showlist:	
				
				mylink = client.request(seasonlist)
				referer = re.findall('<a class="mod-btn mod-btn-watch" href="([^"]+)"', mylink)[0]
				
				epurl = client.request(referer)
				i_d = re.findall(r'id: "(.*?)"', epurl, re.I|re.DOTALL)[0]
				server = re.findall(r'server: "(.*?)"', epurl, re.I|re.DOTALL)[0]
				type = re.findall(r'type: "(.*?)"', epurl, re.I|re.DOTALL)[0]
				episode_id = re.findall(r'episode_id: "(.*?)"', epurl, re.I|re.DOTALL)[0]
				request_url = self.base_link + '/ajax/v3_movie_get_episodes/' + i_d + '/' + server + '/' + episode_id + '/' + type + '.html'
				headers = {'Referer': referer,
							   'User-Agent':'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36',
							   'X-Requested-With':'XMLHttpRequest'}
				
				episodelink = client.request(request_url, headers=headers)
				pattern = 'episodes-server-%s"(.+?)/ul>' % server
				match = re.findall(pattern, episodelink, re.DOTALL)[0]
				blocks = re.compile('<li(.+?)/li>',re.DOTALL).findall(match)
				for fragment in blocks:
					epnumber = re.findall('title="Episode\s+(\d+):', fragment)[0]
					episode = "%02d" % (int(episode))
					epnumber = "%02d" % (int(epnumber))
					if epnumber == episode:
						epid = re.findall('id="episode-(\d+)"', fragment)[0]
						episode_id = epid
						token = self.__get_token()
						cookies = '%s%s%s=%s' % (self.key1, episode_id, self.key2,token)
						url_hash = urllib.quote(self.__uncensored(episode_id + self.key, token))
						url = urlparse.urljoin(self.base_link, self.playlist % (episode_id, url_hash))						

						request_url = url
						self.url.append([request_url,cookies,referer])

			return self.url
        except:
            return		


    def sources(self, url, hostDict, hostprDict):
        try:
			sources = []
			for movielink,cookies,referer in url:
				headers = {'Referer': referer,
							   'User-Agent':'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36',
							   'X-Requested-With':'XMLHttpRequest'}
				result = client.request(movielink, headers=headers, cookie=cookies)
				result = json.loads(result)
				links = result['playlist'][0]['sources']
				for item in links:
					videoq = item['label']
					url = item['file']
					if "1080" in videoq: quality = "1080p" 
					elif "720" in videoq: quality = "HD"
					else: quality = "SD"
					url = client.replaceHTMLCodes(url)
					url = url.encode('utf-8')
					sources.append({'source': 'gvideo', 'quality': quality, 'provider': 'Ymovies', 'url': url, 'direct': True, 'debridonly': False})
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



################### CREDITS FOR TKNORRIS for this FIXES ##############################
		
    def __get_token(self):
        return ''.join(random.sample(string.digits + string.ascii_lowercase, 6))
    
    def __uncensored(self, a, b):
        c = ''
        i = 0
        for i, d in enumerate(a):
            e = b[i % len(b) - 1]
            d = int(self.__jav(d) + self.__jav(e))
            c += chr(d)
    
        return base64.b64encode(c)
    
    def __jav(self, a):
        b = str(a)
        code = ord(b[0])
        if 0xD800 <= code and code <= 0xDBFF:
            c = code
            if len(b) == 1:
                return code
            d = ord(b[1])
            return ((c - 0xD800) * 0x400) + (d - 0xDC00) + 0x10000
    
        if 0xDC00 <= code and code <= 0xDFFF:
            return code
        return code
		
		
