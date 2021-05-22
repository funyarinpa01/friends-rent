import psycopg2
import time

from scripts.queries import queries, num_args


class DataBase:
    """singleton database connection"""
    P = None

    def __init__(self):
        if self.P is None:
            while True:
                try:
                    self.conn = psycopg2.connect(
                        host="localhost",
                        database="testing",
                        user="postgres",
                        password="postgres"
                    )
                    self.cur = self.conn.cursor()
                    break
                except NameError:
                    time.sleep(5)
                    continue
            DataBase.P = self
        else:
            self.conn = self.P.conn
            self.cur = self.P.cur

    def query(self, query_id, *args):
        if not isinstance(query_id, int):
            raise TypeError(f"query_id must be of type integer, not {type(query_id)}")
        if not 1 <= query_id <= 12:
            raise ValueError(f"query_id must be from 1 to 12, not {query_id}")
        if len(args) != num_args[query_id]:
            raise ValueError(f"Query #{query_id} takes {num_args[query_id]} arguments, yet {len(args)} were provided")

        self.cur.execute(queries[query_id], args)
        return self.cur.fetchall()

    def _any_query(self, query_text):
        self.cur.execute(query_text)
        return self.cur.fetchall()

    def close(self):
        if self.P is not None:
            self.P.cur.close()
            self.P.conn.close()


if __name__ == '__main__':
    db = DataBase()

    test = db.query(5)

    db.close()
