-- Table: public.zodiac_signs

-- DROP TABLE IF EXISTS public.zodiac_signs;

CREATE TABLE IF NOT EXISTS public.zodiac_signs
(
    sign_id integer NOT NULL DEFAULT nextval('zodiac_signs_sign_id_seq'::regclass),
    sign_name text COLLATE pg_catalog."default" NOT NULL,
    start_degree numeric(5,2) NOT NULL,
    end_degree numeric(5,2) NOT NULL,
    precessional_order integer NOT NULL,
    color_hex text COLLATE pg_catalog."default" NOT NULL,
    color_name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT zodiac_signs_pkey PRIMARY KEY (sign_id)
)

TABLESPACE pg_default;