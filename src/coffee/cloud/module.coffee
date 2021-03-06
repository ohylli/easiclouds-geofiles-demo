# name it "modul" instead of "module" because of commonjs
modul = angular.module 'cloud', []
modul.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when '/cloud',
      # XXX get rid of /templates/
      templateUrl: '/partials/cloud/templates/cloud.html'
      controller:  require './controllers/cloud-controller.coffee'
]

# Directives
modul.directive 'sliderFilter', require './directives/sliderFilter.coffee'
modul.directive 'checkBoxFilter', require './directives/checkBoxFilter.coffee'
modul.directive 'markerTemplate', require './directives/markerTemplate.coffee'
modul.directive 'selectionsDiv', require './directives/selectionsDiv.coffee'
