class_name Interactable
extends Area2D

signal interacted(root: Node, interactor: Interactor)

func interact(interactor: Interactor):
    interacted.emit(self, interactor)
    print("interacted with {0}".format([self.name]))