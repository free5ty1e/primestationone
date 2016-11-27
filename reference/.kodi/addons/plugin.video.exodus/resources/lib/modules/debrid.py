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


import urllib,json,time

from resources.lib.modules import cache
from resources.lib.modules import control
from resources.lib.modules import client


def rdAuthorize():
    try:
        CLIENT_ID = 'X245A4XAIBGVM'
        USER_AGENT = 'Kodi Exodus/3.0'

        if not '' in credentials()['realdebrid'].values():
            if control.yesnoDialog(control.lang(32531).encode('utf-8'), control.lang(32532).encode('utf-8'), '', 'RealDebrid'):
                control.setSetting(id='realdebrid.id', value='')
                control.setSetting(id='realdebrid.secret', value='')
                control.setSetting(id='realdebrid.token', value='')
                control.setSetting(id='realdebrid.refresh', value='')
                control.setSetting(id='realdebrid.auth', value='')
            raise Exception()

        headers = {'User-Agent': USER_AGENT}
        url = 'https://api.real-debrid.com/oauth/v2/device/code?client_id=%s&new_credentials=yes' % (CLIENT_ID)
        result = client.request(url, headers=headers)
        result = json.loads(result)
        verification_url = (control.lang(32533) % result['verification_url']).encode('utf-8')
        user_code = (control.lang(32534) % result['user_code']).encode('utf-8')
        device_code = result['device_code']
        interval = result['interval']

        progressDialog = control.progressDialog
        progressDialog.create('RealDebrid', verification_url, user_code)

        for i in range(0, 3600):
            try:
                if progressDialog.iscanceled(): break
                time.sleep(1)
                if not float(i) % interval == 0: raise Exception()
                url = 'https://api.real-debrid.com/oauth/v2/device/credentials?client_id=%s&code=%s' % (CLIENT_ID, device_code)
                result = client.request(url, headers=headers, error=True)
                result = json.loads(result)
                if 'client_secret' in result: break
            except:
                pass

        try: progressDialog.close()
        except: pass

        id, secret = result['client_id'], result['client_secret'] 

        url = 'https://api.real-debrid.com/oauth/v2/token'
        post = urllib.urlencode({'client_id': id, 'client_secret': secret, 'code': device_code, 'grant_type': 'http://oauth.net/grant_type/device/1.0'})

        result = client.request(url, post=post, headers=headers)
        result = json.loads(result)

        token, refresh = result['access_token'], result['refresh_token']

        control.setSetting(id='realdebrid.id', value=id)
        control.setSetting(id='realdebrid.secret', value=secret)
        control.setSetting(id='realdebrid.token', value=token)
        control.setSetting(id='realdebrid.refresh', value=refresh)
        control.setSetting(id='realdebrid.auth', value='*************')
        raise Exception()
    except:
        control.openSettings('3.16')


def rdDict():
    try:
        if '' in credentials()['realdebrid'].values(): raise Exception()
        url = 'https://api.real-debrid.com/rest/1.0/hosts/domains'
        result = cache.get(client.request, 24, url)
        hosts = json.loads(result)
        hosts = [i.lower() for i in hosts]
        return hosts
    except:
        return []


def pzDict():
    try:
        if '' in credentials()['premiumize'].values(): raise Exception()
        user, password = credentials()['premiumize']['user'], credentials()['premiumize']['pass']
        url = 'http://api.premiumize.me/pm-api/v1.php?method=hosterlist&params[login]=%s&params[pass]=%s' % (user, password)
        result = cache.get(client.request, 24, url)
        hosts = json.loads(result)['result']['hosterlist']
        hosts = [i.lower() for i in hosts]
        return hosts
    except:
        return []


def adDict():
    try:
        if '' in credentials()['alldebrid'].values(): raise Exception()
        url = 'http://alldebrid.com/api.php?action=get_host'
        result = cache.get(client.request, 24, url)
        hosts = json.loads('[%s]' % result)
        hosts = [i.lower() for i in hosts]
        return hosts
    except:
        return []


def rpDict():
    try:
        if '' in credentials()['rpnet'].values(): raise Exception()
        url = 'http://premium.rpnet.biz/hoster2.json'
        result = cache.get(client.request, 24, url)
        result = json.loads(result)
        hosts = result['supported']
        hosts = [i.lower() for i in hosts]
        return hosts
    except:
        return []


def debridDict():
    return {
    'realdebrid': rdDict(),
    'premiumize': pzDict(),
    'alldebrid': adDict(),
    'rpnet': rpDict()
    }


def credentials():
    return {
        'realdebrid': {
        'id': control.setting('realdebrid.id'),
        'secret': control.setting('realdebrid.secret'),
        'token': control.setting('realdebrid.token'),
        'refresh': control.setting('realdebrid.refresh')
    },
        'premiumize': {
        'user': control.setting('premiumize.user'),
        'pass': control.setting('premiumize.pin')
    },
        'alldebrid': {
        'user': control.setting('alldebrid.user'),
        'pass': control.setting('alldebrid.pass')
    },
        'rpnet': {
        'user': control.setting('rpnet.user'),
        'pass': control.setting('rpnet.api')
    }}


def status():
    try:
        c = [i for i in credentials().values() if not '' in i.values()]
        if len(c) == 0: return False
        else: return True
    except:
        return False


def resolver(url, debrid):
    u = url
    u = u.replace('filefactory.com/stream/', 'filefactory.com/file/')

    try:
        if not debrid == 'realdebrid' and not debrid == True: raise Exception()

        if '' in credentials()['realdebrid'].values(): raise Exception()
        id, secret, token, refresh = credentials()['realdebrid']['id'], credentials()['realdebrid']['secret'], credentials()['realdebrid']['token'], credentials()['realdebrid']['refresh']

        USER_AGENT = 'Kodi Exodus/3.0'

        post = urllib.urlencode({'link': u})
        headers = {'Authorization': 'Bearer %s' % token, 'User-Agent': USER_AGENT}
        url = 'https://api.real-debrid.com/rest/1.0/unrestrict/link'

        result = client.request(url, post=post, headers=headers, error=True)
        result = json.loads(result)

        if 'error' in result and result['error'] == 'bad_token':
            result = client.request('https://api.real-debrid.com/oauth/v2/token', post=urllib.urlencode({'client_id': id, 'client_secret': secret, 'code': refresh, 'grant_type': 'http://oauth.net/grant_type/device/1.0'}), headers={'User-Agent': USER_AGENT}, error=True)
            result = json.loads(result)
            if 'error' in result: return

            headers['Authorization'] = 'Bearer %s' % result['access_token']
            result = client.request(url, post=post, headers=headers)
            result = json.loads(result)

        url = result['download']
        return url
    except:
        pass

    try:
        if not debrid == 'premiumize' and not debrid == True: raise Exception()

        if '' in credentials()['premiumize'].values(): raise Exception()
        user, password = credentials()['premiumize']['user'], credentials()['premiumize']['pass']

        url = 'http://api.premiumize.me/pm-api/v1.php?method=directdownloadlink&params[login]=%s&params[pass]=%s&params[link]=%s' % (user, password, urllib.quote_plus(u))
        result = client.request(url, close=False)
        url = json.loads(result)['result']['location']
        return url
    except:
        pass

    try:
        if not debrid == 'alldebrid' and not debrid == True: raise Exception()

        if '' in credentials()['alldebrid'].values(): raise Exception()
        user, password = credentials()['alldebrid']['user'], credentials()['alldebrid']['pass']

        login_data = urllib.urlencode({'action': 'login', 'login_login': user, 'login_password': password})
        login_link = 'http://alldebrid.com/register/?%s' % login_data
        cookie = client.request(login_link, output='cookie', close=False)

        url = 'http://www.alldebrid.com/service.php?link=%s' % urllib.quote_plus(u)
        result = client.request(url, cookie=cookie, close=False)
        url = client.parseDOM(result, 'a', ret='href', attrs = {'class': 'link_dl'})[0]
        url = client.replaceHTMLCodes(url)
        url = '%s|Cookie=%s' % (url, urllib.quote_plus(cookie))
        return url
    except:
        pass

    try:
        if not debrid == 'rpnet' and not debrid == True: raise Exception()

        if '' in credentials()['rpnet'].values(): raise Exception()
        user, password = credentials()['rpnet']['user'], credentials()['rpnet']['pass']

        login_data = urllib.urlencode({'username': user, 'password': password, 'action': 'generate', 'links': u})
        login_link = 'http://premium.rpnet.biz/client_api.php?%s' % login_data
        result = client.request(login_link, close=False)
        result = json.loads(result)
        url = result['links'][0]['generated']
        return url
    except:
        return


