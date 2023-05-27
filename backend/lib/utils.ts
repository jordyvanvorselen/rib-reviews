import { Db, ObjectId } from "mongodb";

export const dateIsValid = (date: string, validWhenNull: boolean = false) => {
  if (!date) return validWhenNull;
  if (Date.parse(date) > 0) return true;

  return false;
};

export const documentExists = async (db: Db, collection: string, id: number) => {
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
