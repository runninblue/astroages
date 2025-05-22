import psycopg2, sys, logging, os
from tabulate import tabulate
from configparser import ConfigParser

def setup_logging():
    logging.basicConfig(
        filename='astroages.log',
        filemode='w',
        level=logging.INFO,
        format='%(asctime)s:%(levelname)s:%(message)s'
    )
    logging.info("Starting the program...")

def config(filename='db.ini', section='postgresql'):
    # Create a parser
    parser = ConfigParser()
    
    try:
        # Read config file
        parser.read(filename)

        # Get section, default to postgresql
        db = {}
        if parser.has_section(section):
            params = parser.items(section)
            for param in params:
                db[param[0]] = param[1]
        else:
            raise Exception('Section {0} not found in the {1} file'.format(section, filename))
    except FileNotFoundError:
        logging.critical(f"Configuration file {filename} not found.")
    except Exception as e:
        logging.exception(f"Error reading configuration file: {e}")
    return db

def connect_to_db(**params):
    try:
        conn = psycopg2.connect(**params['params'])
    except psycopg2.OperationalError as e:
        logging.critical(f"OperationalError: {e}")
        return None, None
    except Exception as e:
        logging.critical(f"Error connecting to the database: {e}")
        return None, None
    else:
        cur = conn.cursor()
        return conn, cur

def hex_to_rgb(hex):
    try:
        rgb = tuple(int(hex[i:i+2], 16) for i in (0, 2, 4))
    except ValueError:
        logging.critical(f"Invalid hex color code: {hex}")
    else:
        return rgb

def colored(r, g, b, text):
    if not isinstance(r, int) or not isinstance(g, int) or not isinstance(b, int):
        logging.critical("RGB values must be integers.")
        return text
    if not (0 <= r <= 255 and 0 <= g <= 255 and 0 <= b <= 255):
        logging.critical("RGB values must be in the range 0-255.")
        return text
    if not isinstance(text, str):
        logging.critical("Text must be a string.")
        return text
    if not text:
        logging.critical("Text cannot be empty.")
        return text
    return f"\033[38;2;{r};{g};{b}m{text}\033[0m"

def process_records(records):
    for r in records:
        color = r.pop(1)
        if not color.startswith("#"):
            logging.critical(f"Invalid color format: {color}")
            continue
        else:
            rgb_color = hex_to_rgb(color.lstrip("#"))
            if rgb_color is None:
                logging.critical(f"Invalid hex color code: {color}")
                continue
            else:
                r[0] = colored(rgb_color[0], rgb_color[1], rgb_color[2], str(r[0]))
                r[1] = colored(rgb_color[0], rgb_color[1], rgb_color[2], str(r[1]))
                r[2] = colored(rgb_color[0], rgb_color[1], rgb_color[2], str(r[2]))
                r[3] = colored(rgb_color[0], rgb_color[1], rgb_color[2], str(r[3]))
    return records    

def get_astrological_ages(conn, cur, start_year, end_year):
    sql_query = f"SELECT * FROM generate_zodiac_timeline({start_year}{',' if start_year else ''}{end_year})"
    cur.execute(sql_query)
    records = [list(r) for r in cur.fetchall()]
    cur.close()
    conn.close()
    if records:
        records = process_records(records)
    else:
        print("No records found.")
    return records

def load_config():    
    if not 'db.ini' in os.listdir():
        if 'db-template.ini' not in os.listdir():
            logging.critical("Configuration file db-template.ini not found.")
            exit(1)
        else:
            os.rename('db-template.ini', 'db.ini')
            logging.info("Configuration file db-template.ini renamed to db.ini.")
    else:
        logging.info("Configuration file db.ini found.")
    
    DB_PARAMS = config()
    return DB_PARAMS

if __name__ == "__main__":
    HEADERS = ["Age",
           "Start Range",
           "End Range",
           "Years Count"]
    
    DB_PARAMS = load_config()
    ARGUMENTS = sys.argv[1:]

    setup_logging()
    logging.info("Program started with arguments: %s", ARGUMENTS)
    logging.info("Checking database configuration...")
    
    if not DB_PARAMS:
        logging.error("Database configuration not found.")
        exit(1)
    else:
        logging.info("Database configuration found.")
        conn, cur = connect_to_db(params=DB_PARAMS)  
                
        if conn is None or cur is None:
            logging.critical("Failed to connect to the database.")
            exit(1)
        else:
            logging.info("Connected to the database.")
            start_year = ''
            end_year = ''
            if len(ARGUMENTS) > 2:
                print("Usage: python astroages.py [start_year] [end_year]")
                exit(1)
            elif len(ARGUMENTS) == 2:
                try:
                    start_year = int(ARGUMENTS[0])
                    end_year = int(ARGUMENTS[1])
                except ValueError:
                    logging.critical("Invalid year format. Please provide valid integers.")
                    exit(1)
            elif len(ARGUMENTS) == 1:
                try:
                    end_year = int(ARGUMENTS[0])
                except ValueError:
                    logging.critical("Invalid year format. Please provide valid integer.")
                    exit(1)

            if start_year or end_year:
                logging.info(f"Fetching astrological ages from {start_year} to {end_year}...")
                records = get_astrological_ages(conn, cur, start_year, end_year)
            else:
                logging.warning("No start or end year provided.")
                logging.info("Fetching astrological age for current year...")
                records = get_astrological_ages(conn, cur, start_year, end_year)
            
            if not records:
                logging.error("No records found.")
                print("No records found.")
                exit(1)
            else:
                logging.info("Records fetched successfully.")
                print("\n\t\tAstrological Ages\n")
                print(tabulate(records, headers=HEADERS, tablefmt="grid"))
                exit(0)