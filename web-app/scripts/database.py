import psycopg2
import time
import datetime

from scripts.queries import queries, num_args


class DataBase:
    """singleton database connection"""
    P = None

    def __init__(self):
        if self.P is None:
            while True:
                try:
                    self.conn = psycopg2.connect(  # ask @lmao_bs if you want to connect TODO fucking hide credentials
                        host="ec2-54-73-68-39.eu-west-1.compute.amazonaws.com",
                        database="d766e7a5lj891n",
                        user="mimmpbfogysuir",
                        password="ca24ec0e0a874062d4950b2064fb2745ab6f7478955a750c868b824f8974c632"
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

    def run_task_query(self, query_id, *args, verbose=False):
        if not isinstance(query_id, int):
            raise TypeError(f"query_id must be of type integer, not {type(query_id)}")
        if not 1 <= query_id <= 12:
            raise ValueError(f"query_id must be from 1 to 12, not {query_id}")
        if len(args) != num_args[query_id - 1]:
            raise ValueError(
                f"Query #{query_id} takes {num_args[query_id - 1]} arguments, yet {len(args)} were provided")

        self.cur.execute(queries[query_id - 1], args)
        if verbose:
            print(self.cur.statusmessage)

        self.conn.commit()
        return self.cur.fetchall()

    def run_query(self, query_text, verbose=False):
        self.cur.execute(query_text)
        if verbose:
            print(self.cur.statusmessage)

        self.conn.commit()
        if self.cur.statusmessage.split()[0] == "SELECT":
            return self.cur.fetchall()
        else:
            return None

    def close(self):
        if self.P is not None:
            self.P.cur.close()
            self.P.conn.close()


if __name__ == '__main__':
    db = DataBase()

    res = db.run_task_query(1,  # query id
                            'Oleksandr Dubas', datetime.date(2021, 5, 1), datetime.date(2021, 5, 10), 1, # arguments (as ordered in query) TODO somehow signify the order
                            verbose=True)  # print query status

    print(res)

    db.close()
