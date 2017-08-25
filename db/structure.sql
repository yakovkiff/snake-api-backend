SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: games; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE games (
    id bigint NOT NULL,
    frontend_id integer,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE games_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE games_id_seq OWNED BY games.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: snake_heads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE snake_heads (
    id bigint NOT NULL,
    bearing character varying,
    x integer,
    y integer,
    game_id bigint
);


--
-- Name: snake_heads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE snake_heads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snake_heads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE snake_heads_id_seq OWNED BY snake_heads.id;


--
-- Name: tails; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tails (
    id bigint NOT NULL,
    bearing character varying,
    x integer,
    y integer,
    snake_head_id bigint
);


--
-- Name: tails_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tails_id_seq OWNED BY tails.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id bigint NOT NULL,
    name character varying,
    games_played integer,
    email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    high_score integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY games ALTER COLUMN id SET DEFAULT nextval('games_id_seq'::regclass);


--
-- Name: snake_heads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY snake_heads ALTER COLUMN id SET DEFAULT nextval('snake_heads_id_seq'::regclass);


--
-- Name: tails id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tails ALTER COLUMN id SET DEFAULT nextval('tails_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: snake_heads snake_heads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY snake_heads
    ADD CONSTRAINT snake_heads_pkey PRIMARY KEY (id);


--
-- Name: tails tails_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tails
    ADD CONSTRAINT tails_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_games_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_games_on_user_id ON games USING btree (user_id);


--
-- Name: index_snake_heads_on_game_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_snake_heads_on_game_id ON snake_heads USING btree (game_id);


--
-- Name: index_tails_on_snake_head_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tails_on_snake_head_id ON tails USING btree (snake_head_id);


--
-- Name: snake_heads fk_rails_0c4c5ae423; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY snake_heads
    ADD CONSTRAINT fk_rails_0c4c5ae423 FOREIGN KEY (game_id) REFERENCES games(id);


--
-- Name: tails fk_rails_aabc2b7eb1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tails
    ADD CONSTRAINT fk_rails_aabc2b7eb1 FOREIGN KEY (snake_head_id) REFERENCES snake_heads(id);


--
-- Name: games fk_rails_de9e6ea7f7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY games
    ADD CONSTRAINT fk_rails_de9e6ea7f7 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20170821154933'),
('20170821155855'),
('20170823215341'),
('20170823215448'),
('20170825041555');


