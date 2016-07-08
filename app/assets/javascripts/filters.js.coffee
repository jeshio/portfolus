angular.module('portfolus').filter('domenFromUrl', ->
  (input) ->
    if !input? or input.length is 0
      return ''
    domain = undefined
    #find & remove protocol (http, ftp, etc.) and get domain
    if input.indexOf('://') > -1
      domain = input.split('/')[2]
    else
      domain = input.split('/')[0]
    `a = document.createElement('a')`
    a.href = 'http://' + domain
    parts = a.hostname.split('.')
    if parts.length < 2
      return ''
    rootDomain = parts[parts.length - 2] + '.' + parts[parts.length - 1]
    rootDomain
).filter('range', ->
  (input, total) ->
    total = parseInt(total)
    i = 0
    while i < total
      input.push i
      i++
    input
).filter('shortMonthName', [ ->
  (monthNumber) ->
    monthNames = [
      'Я'
      'Ф'
      'М'
      'А'
      'М'
      'И'
      'И'
      'А'
      'С'
      'О'
      'Н'
      'Д'
    ]
    monthNames[monthNumber - 1]
 ]).filter 'monthName', [ ->
  (monthNumber) ->
    monthNames = [
      'ЯНВ'
      'ФЕВ'
      'МАР'
      'АПР'
      'МАЙ'
      'ИЮН'
      'ИЮЛ'
      'АВГ'
      'СЕН'
      'ОКТ'
      'НОЯ'
      'ДЕК'
    ]
    monthNames[monthNumber - 1]
 ]
