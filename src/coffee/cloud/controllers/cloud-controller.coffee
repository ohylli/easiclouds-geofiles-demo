module.exports = ['$scope', '$routeParams', '$http', ($scope, $routeParams, $http) ->
  $scope.options = ['suomi', 'ruotsi']

  FILES_API = config.apiUrl + '/files'
  SERVERS_API = config.apiUrl + '/servers'
  $scope.legendWithUser =
    position: 'bottomleft'
    colors: ['#2981ca', '#00cb73', '#646464']
    labels: ['Your location', 'Servers with the file', 'Servers without the file']
  $scope.legendWithoutUser =
    position: 'bottomleft'
    colors: ['#00cb73', '#2981ca', '#646464']
    labels: ['The server serving you the file', 'Servers with the file', 'Servers without the file']

  # TODO: legend is wrong if user denies geolocation, it doesn't update
  # after the map has been loaded
  $scope.legend = if navigator.geolocation then $scope.legendWithUser else $scope.legendWithoutUser

  icons =
    active:
      iconUrl: 'images/marker-icon-active.png'
    inactive:
      iconUrl: 'images/marker-icon-inactive.png'
  $scope.url = 'http://www.leonidasoy.fi'
  $scope.markers = {}
  $scope.paths = {}
  $scope.europeCenter =
    lat: 55.0
    lng: 8.0
    zoom: 5
  $scope.userPosition = {}

  transformMarkers = (m) ->
    indexBy(m, (val) -> val.message.replace(/[. ]/g, ''))

  transformUserPosition = ->
    $scope.markers = _.assign($scope.markers,
      userlocation:
        lat: $scope.userPosition.coords.latitude
        lng: $scope.userPosition.coords.longitude
        message: 'User location'
        icon: {}) if !_.isEmpty($scope.userPosition)

  $scope.getUserLocation = ->
    navigator.geolocation.getCurrentPosition((pos) ->
      $scope.userPosition = pos
      $scope.legend = $scope.legendWithUser
      transformUserPosition()) if navigator.geolocation

  $scope.queryServers = ->
    $http(method: 'GET', url: SERVERS_API)
      .success((data, status, headers, config) ->
        $scope.markers = transformMarkers(_.map(data.servers, (s) ->
          lat: s.coordinates.lat
          lng: s.coordinates.lng
          message: "<h3>" + s.title + "</h3>" + s.memory + 'Gb RAM<br/>' + s.cpucores + ' CPU cores<br/>' + s.storage + 'Gb storage<br/><button id=\'chooseButton\'>CHOOSE</button>'
          icon: icons.inactive)))

  $scope.queryServers()
  $scope.getUserLocation()
]
