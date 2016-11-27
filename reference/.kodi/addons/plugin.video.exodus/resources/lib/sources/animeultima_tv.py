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


class source:
    def __init__(self):
        self.domains = ['animeultima.io']
        self.base_link = 'http://www.animeultima.io'
        self.search_link = '/search.html?searchquery=%s'


    def tvshow(self, imdb, tvdb, tvshowtitle, year):
        try:
            genre = 'http://www.imdb.com/title/%s/' % imdb
            genre = client.request(genre)
            genre = re.findall('href\s*=\s*[\'|\"](.+?)[\'|\"]', genre)
            genre = [i for i in genre if '/genre/' in i]
            genre = [i.split('/genre/')[-1].split('?')[0].lower() for i in genre]
            if not 'animation' in genre: raise Exception()

            query = self.search_link % (urllib.quote_plus(tvshowtitle))
            query = urlparse.urljoin(self.base_link, query)

            result = client.request(query)
            result = result.decode('iso-8859-1').encode('utf-8')

            tvshowtitle = cleantitle.get(tvshowtitle)

            result = client.parseDOM(result, 'ol', attrs = {'id': 'searchresult'})[0]
            result = client.parseDOM(result, 'h2')
            result = [(client.parseDOM(i, 'a', ret='href'), client.parseDOM(i, 'a')) for i in result]
            result = [(i[0][0], i[1][0]) for i in result if len(i[0]) > 0 and len(i[1]) > 0]
            result = [(i[0], re.sub('<.+?>|</.+?>','', i[1])) for i in result]
            result = [i for i in result if tvshowtitle == cleantitle.get(i[1])]
            result = result[-1][0]

            url = urlparse.urljoin(self.base_link, result)
            url = urlparse.urlparse(url).path
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

            url = urlparse.urljoin(self.base_link, url)

            result = client.request(url)
            result = result.decode('iso-8859-1').encode('utf-8')

            result = client.parseDOM(result, 'tr', attrs = {'class': ''})
            result = [(client.parseDOM(i, 'a', ret='href'), client.parseDOM(i, 'td', attrs = {'class': 'epnum'})) for i in result]
            result = [(i[0][0], i[1][0]) for i in result if len(i[0]) > 0 and len(i[1]) > 0]
            result = [i[0] for i in result if num == i[1]][0]

            url = urlparse.urljoin(self.base_link, result)
            url = urlparse.urlparse(url).path
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

            sources.append({'source': 'animeultima', 'quality': 'SD', 'provider': 'Animeultima', 'url': url, 'direct': True, 'debridonly': False})
            return sources
        except:
            return sources


    def resolve(self, url):
        try:
            result = client.request(url)
            result = result.decode('iso-8859-1').encode('utf-8')

            url = client.parseDOM(result, 'div', attrs = {'class': 'player-embed'})[0]
            url = client.parseDOM(url, 'iframe', ret='src')[0]

            try:
                if 'auengine.com' in url: raise Exception()

                result = client.parseDOM(result, 'div', attrs = {'class': 'generic-video-item'})
                result = [(client.parseDOM(i, 'a', ret='href', attrs = {'rel': '.+?'}), i) for i in result]
                result = [i for i in result if len(i[0]) > 0]

                item = [i[0][0] for i in result if 'auengine video' in i[1].lower()]
                item += [i[0][0] for i in result if 'mp4upload video' in i[1].lower()]
                item = urlparse.urljoin(self.base_link, item[0])

                result = client.request(item)
                result = result.decode('iso-8859-1').encode('utf-8')

                item = client.parseDOM(result, 'div', attrs = {'class': 'player-embed'})[0]
                url = client.parseDOM(item, 'iframe', ret='src')[0]
            except:
                pass

            result = client.request(url)

            try: url = re.compile("'file'\s*:\s*'(.+?)'").findall(result)[0]
            except: pass
            try: url = re.compile("video_link *= *'(.+?)'").findall(result)[0]
            except: pass

            url = urllib.unquote_plus(url)
            return url
        except:
            return


