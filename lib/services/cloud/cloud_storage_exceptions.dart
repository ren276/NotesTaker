class CloudStorageException implements Exception {
  const CloudStorageException();
}
// c in crud
class CouldNotCreateNoteException extends CloudStorageException{

}
//R in crud
class CouldNotGetAllNotesException extends CloudStorageException{}

// u in crud
class CouldNotUpdateNotesException extends CloudStorageException{}

//d in crud
class CouldNotDeleteException extends CloudStorageException{}