//package com.journaldev.design.memento;

/*
 * Notice that caretaker object contains the saved state in the form of Object,
 * so it can’t alter its data and also it has no knowledge of it’s structure.
 */
public class FileWriterCaretaker {

	private Object obj;
	
	public void save(FileWriterUtil fileWriter){
		this.obj = fileWriter.save();
	}
	
	public void undo(FileWriterUtil fileWriter){
		fileWriter.undoToLastSave(obj);
	}
}
