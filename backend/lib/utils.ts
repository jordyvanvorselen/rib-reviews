import { Db, ObjectId } from "mongodb";

export const dateIsValid = (date: string, validWhenNull: boolean = false) => {
  if (!date) return validWhenNull;

  return Date.parse(date) > 0;
};

export const documentExists = async (db: Db, collection: string, id: string) => {
  if (!ObjectId.isValid(id)) return false;

  return (
    (
      await db
        .collection(collection)
        .find({ _id: new ObjectId(id) })
        .toArray()
    ).length > 0
  );
};
