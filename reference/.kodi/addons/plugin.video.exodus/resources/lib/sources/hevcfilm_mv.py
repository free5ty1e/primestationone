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


import re,urllib,urlparse,datetime

from resources.lib.modules import cleantitle
from resources.lib.modules import client
from resources.lib.modules import debrid


class source:
    def __init__(self):
        self.domains = ['hevcbluray.com']
        self.base_link = 'https://hevcbluray.com'
        self.search_link = '/?s=%s'


    def movie(self, imdb, title, year):
        try:
            url = {'imdb': imdb, 'title': title, 'year': year}
            url = urllib.urlencode(url)
            return url
        except:
            return


    def sources(self, url, hostDict, hostprDict):
        try:
            sources = []

            if url == None: return sources

            if debrid.status() == False: raise Exception()

            data = urlparse.parse_qs(url)
            data = dict([(i, data[i][0]) if data[i] else (i, '') for i in data])

            query = re.sub('(\\\|/|-|:|;|\*|\?|"|\'|<|>|\|)', ' ', data['title'])
            query = self.search_link % urllib.quote_plus(query)
            query = urlparse.urljoin(self.base_link, query)

            r = client.request(query)

            r = client.parseDOM(r, 'div', attrs = {'class': 'item'})

            r = [(client.parseDOM(i, 'a', ret='href'), client.parseDOM(i, 'span', attrs = {'class': 'calidad2'}), client.parseDOM(i, 'span', attrs = {'class': 'tt'}), client.parseDOM(i, 'span', attrs = {'class': 'year'})) for i in r]
            r = [(i[0][0], i[1][0], i[2][0], i[3][0]) for i in r if len(i[0]) > 0 and len(i[1]) > 0 and len(i[2]) > 0 and len(i[3]) > 0]
            r = [(i[0], i[1], i[2]) for i in r if i[3] == data['year'] and not i[1] == '3D']
            r = [(i[0], i[1], re.sub('(\.|\(|\[|\s)(1080p|720p|3D|\d{4})(\.|\)|\]|\s|)(.+|)', '', i[2])) for i in r]
            r = [(i[0], i[1]) for i in r if cleantitle.get(data['title']) == cleantitle.get(i[2])]


            l = [(i[0], '1080p') for i in r if i[1] == '1080p'][:1]
            l += [(i[0], 'HD') for i in r if i[1] == '720p'][:1]

            quality = l[0][1]

            hostDict = hostprDict + hostDict

            url = l[0][0]
            url = client.replaceHTMLCodes(url)


            r = client.request(url)

            try:
                links = client.parseDOM(r, 'div', attrs = {'class': 'enlaces_box'})[0]
                links = client.parseDOM(links, 'a', ret='href')
            except:
                links = client.parseDOM(r, 'div', attrs = {'class': 'txt-block'})[0]
                links = links.split('Download Link')[-1]
                links = client.parseDOM(links, 'strong')
                links = client.parseDOM(links, 'a', ret='href')

            for url in links:
                try:
                    url = client.replaceHTMLCodes(url)
                    url = url.encode('utf-8')

                    host = re.findall('([\w]+[.][\w]+)$', urlparse.urlparse(url.strip().lower()).netloc)[0]
                    if not host in hostDict: raise Exception()
                    host = client.replaceHTMLCodes(host)
                    host = host.encode('utf-8')

                    sources.append({'source': host, 'quality': quality, 'provider': 'Hevcfilm', 'url': url, 'info': 'HEVC', 'direct': False, 'debridonly': True})
                except:
                    pass

            return sources
        except:
            return sources


    def resolve(self, url):
        return url


