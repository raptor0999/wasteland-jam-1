extends Node

var shootingGalleryComplete = 0
var zombieWhackComplete = 0
var clownMouthComplete = 0
var zombiesKilled = 0.0
var attemptsRemaining = 3

var currentTeleport

func isWin():
	if zombiesKilled > 14.0 and shootingGalleryComplete and zombieWhackComplete and clownMouthComplete:
		return true

func isLose():
	if attemptsRemaining < 1:
		return true
