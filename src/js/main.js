angular.module('app', ['ngRoute', 'ngAnimate', 'ngTouch'])

// Main controller
.controller('appController', ['$scope', '$rootScope', function($scope, $rootScope) {
  console.log('appController');

  $scope.stuff = "it workssss";




}]);

// FastClick
window.addEventListener('load', function() {
  FastClick.attach(document.body);
}, false);