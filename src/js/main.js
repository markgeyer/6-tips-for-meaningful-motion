angular.module('app', ['ngRoute', 'ngAnimate', 'ngTouch'])

// Main controller
.controller('appController', ['$scope', '$rootScope', function($scope, $rootScope) {
  console.log('appController');

  $scope.stuff = "it workssss";


  // overboard ani
  $scope.isOverboard = false;

	var overboardAudio = document.createElement('audio');
	overboardAudio.setAttribute('src', 'img/overboardAudio.mp3');
	overboardAudio.load();

  $scope.goOverboard = function() {
    $scope.isOverboard = true;
    overboardAudio.play();
    console.log('play');

    setTimeout(function() {
      $scope.$apply(function(){
        $scope.isOverboard = false;
        console.log('ended');
      });
    }, 34000);
  };


}]);

// FastClick
window.addEventListener('load', function() {
  FastClick.attach(document.body);
}, false);