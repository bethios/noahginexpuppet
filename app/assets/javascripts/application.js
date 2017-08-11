// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require interact/interact
//= require_tree .

interact('.resize-drag')
    .draggable({
        onmove: window.dragMoveListener
    })
    .resizable({
        preserveAspectRatio: true,
        edges: { left: true, right: true, bottom: true, top: true }
    })
    .on('resizemove', function (event) {
        var target = event.target,
            x = (parseFloat(target.getAttribute('data-x')) || 0),
            y = (parseFloat(target.getAttribute('data-y')) || 0);

        target.style.width  = event.rect.width + 'px';
        target.style.height = event.rect.height + 'px';

        // translate when resizing from top or left edges
        x += event.deltaRect.left;
        y += event.deltaRect.top;

        target.style.webkitTransform = target.style.transform =
            'translate(' + x + 'px,' + y + 'px)';

        target.setAttribute('data-x', x);
        target.setAttribute('data-y', y);
    });

interact('.draggable')
    .draggable({
        inertia: true,
        restrict: {
            endOnly: true,
            elementRect: { top: 0, left: 0, bottom: 1, right: 1 }
        },
        autoScroll: true,

        onmove: dragMoveListener,
        onend: function (event) {
            var textEl = event.target.querySelector('p');
        }
    });

function dragMoveListener (event) {
    var target = event.target,
        x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx,
        y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy;

    target.style.webkitTransform =
        target.style.transform =
            'translate(' + x + 'px, ' + y + 'px)';

    target.setAttribute('data-x', x);
    target.setAttribute('data-y', y);
}

window.dragMoveListener = dragMoveListener;

    $(window).on('load',function(){
        $('#monsterModal').modal('show');
    });

var holes = document.getElementsByClassName('hole');
var scoreBoard = document.getElementsByClassName('score')[0];
var moles = document.getElementsByClassName('mole');

var lastHole;
var timeUp;
var score = 0;

function generateRandomTime(min, max){
    return Math.round(Math.random() * (max - min) + min);
}
function getRandomHole(holes){
    var index = Math.floor(Math.random() * holes.length );
    var hole = holes[index];
    if(hole === lastHole){
        return getRandomHole(holes)
    }
    lastHole = hole;
    return hole;
}

function peep(){
    var time = generateRandomTime(400, 1100);
    var hole = getRandomHole(holes);
    hole.classList.add('up');
    setTimeout(function(){
        hole.classList.remove('up');
    if(!timeUp) peep();
    }, time)
}
function runGame(){
    for(var i =0; i< moles.length; i++){
        moles[i].addEventListener('click', bonk)
    }
    score = 0;
    document.getElementsByClassName('score')[0].innerHTML = 0;
    timeUp = false;
    peep();
    setTimeout(function(){timeUp = true}, 15000);
}
function bonk(e) {
    var mole = this;
    this.classList.add('bonked');
    if(!e.isTrusted) return; //cheater!
    score ++;
    setTimeout(function(){
        mole.classList.remove('up');
        mole.classList.remove('bonked');
    }, 300);
    document.getElementsByClassName('score')[0].innerHTML = score
}
