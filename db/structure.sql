SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: birthdays; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.birthdays (
    id bigint NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    date date NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: birthdays_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.birthdays_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: birthdays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.birthdays_id_seq OWNED BY public.birthdays.id;


--
-- Name: birthdays_with_upcoming; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.birthdays_with_upcoming AS
 SELECT id,
    first_name,
    last_name,
    date,
    created_at,
    updated_at,
    upcoming_birthday,
        CASE
            WHEN ((upcoming_birthday - '6 mons'::interval) >= CURRENT_DATE) THEN (upcoming_birthday - '6 mons'::interval)
            ELSE (upcoming_birthday + '6 mons'::interval)
        END AS upcoming_midpoint
   FROM ( SELECT birthdays.id,
            birthdays.first_name,
            birthdays.last_name,
            birthdays.date,
            birthdays.created_at,
            birthdays.updated_at,
                CASE
                    WHEN (make_date((EXTRACT(year FROM CURRENT_DATE))::integer, (EXTRACT(month FROM birthdays.date))::integer, (EXTRACT(day FROM birthdays.date))::integer) >= CURRENT_DATE) THEN make_date((EXTRACT(year FROM CURRENT_DATE))::integer, (EXTRACT(month FROM birthdays.date))::integer, (EXTRACT(day FROM birthdays.date))::integer)
                    ELSE make_date(((EXTRACT(year FROM CURRENT_DATE))::integer + 1), (EXTRACT(month FROM birthdays.date))::integer, (EXTRACT(day FROM birthdays.date))::integer)
                END AS upcoming_birthday
           FROM public.birthdays) base;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: birthdays id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.birthdays ALTER COLUMN id SET DEFAULT nextval('public.birthdays_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: birthdays birthdays_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.birthdays
    ADD CONSTRAINT birthdays_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_birthdays_on_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_birthdays_on_date ON public.birthdays USING btree (date);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20260123142610'),
('20260106114944');

