--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.2

-- Started on 2024-05-25 11:55:40 UTC

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

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 222 (class 1255 OID 16561)
-- Name: add_player_to_users(); Type: FUNCTION; Schema: public; Owner: docker
--

CREATE FUNCTION public.add_player_to_users() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO users (username, password, role, player_id, changed_password)
    VALUES (LOWER(NEW.name) || LOWER(NEW.surname) || '@milano.com', 'default', 'player', NEW.player_id, FALSE);
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.add_player_to_users() OWNER TO docker;

--
-- TOC entry 223 (class 1255 OID 16565)
-- Name: update_player_with_injury(); Type: FUNCTION; Schema: public; Owner: docker
--

CREATE FUNCTION public.update_player_with_injury() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE players
    SET injury_id = NEW.injury_id
    WHERE player_id = NEW.player_id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_player_with_injury() OWNER TO docker;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16532)
-- Name: injuries; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.injuries (
    injury_id integer NOT NULL,
    player_id integer NOT NULL,
    type character varying(255) NOT NULL,
    location character varying(255) NOT NULL,
    date date NOT NULL,
    description text,
    feelings text,
    next_visit timestamp without time zone
);


ALTER TABLE public.injuries OWNER TO docker;

--
-- TOC entry 220 (class 1259 OID 16531)
-- Name: injuries_injury_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.injuries_injury_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.injuries_injury_id_seq OWNER TO docker;

--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 220
-- Name: injuries_injury_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.injuries_injury_id_seq OWNED BY public.injuries.injury_id;


--
-- TOC entry 216 (class 1259 OID 16483)
-- Name: players; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.players (
    player_id integer NOT NULL,
    name character varying(255) NOT NULL,
    surname character varying(255) NOT NULL,
    "position" character varying(100) NOT NULL,
    contract_ends date NOT NULL,
    image character varying(255) NOT NULL,
    statistics_id integer,
    injury_id integer
);


ALTER TABLE public.players OWNER TO docker;

--
-- TOC entry 215 (class 1259 OID 16482)
-- Name: players_player_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.players_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.players_player_id_seq OWNER TO docker;

--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 215
-- Name: players_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.players_player_id_seq OWNED BY public.players.player_id;


--
-- TOC entry 219 (class 1259 OID 16507)
-- Name: statistics; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.statistics (
    statistics_id integer NOT NULL,
    player_id integer NOT NULL,
    goals integer DEFAULT 0,
    assists integer DEFAULT 0,
    passes_completed integer DEFAULT 0,
    distance_covered double precision DEFAULT 0,
    fouls integer DEFAULT 0,
    yellow_cards integer DEFAULT 0,
    red_cards integer DEFAULT 0,
    shots_on_target integer DEFAULT 0,
    saves integer DEFAULT 0,
    feedback text
);


ALTER TABLE public.statistics OWNER TO docker;

--
-- TOC entry 218 (class 1259 OID 16506)
-- Name: statistics_statistics_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.statistics_statistics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.statistics_statistics_id_seq OWNER TO docker;

--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 218
-- Name: statistics_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.statistics_statistics_id_seq OWNED BY public.statistics.statistics_id;


--
-- TOC entry 217 (class 1259 OID 16491)
-- Name: users; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.users (
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(50) DEFAULT 'player'::character varying,
    player_id integer,
    changed_password boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO docker;

--
-- TOC entry 3232 (class 2604 OID 16535)
-- Name: injuries injury_id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.injuries ALTER COLUMN injury_id SET DEFAULT nextval('public.injuries_injury_id_seq'::regclass);


--
-- TOC entry 3219 (class 2604 OID 16486)
-- Name: players player_id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.players ALTER COLUMN player_id SET DEFAULT nextval('public.players_player_id_seq'::regclass);


--
-- TOC entry 3222 (class 2604 OID 16510)
-- Name: statistics statistics_id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.statistics ALTER COLUMN statistics_id SET DEFAULT nextval('public.statistics_statistics_id_seq'::regclass);


--
-- TOC entry 3403 (class 0 OID 16532)
-- Dependencies: 221
-- Data for Name: injuries; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.injuries (injury_id, player_id, type, location, date, description, feelings, next_visit) FROM stdin;
9	14	sprinkled ankle	aa	2024-05-25	asasd	adsasd	2024-05-25 13:13:00
11	15	broken leg	asddas	2024-06-09	asdasdadsa	sdasdasd	2024-05-25 13:20:00
\.


--
-- TOC entry 3398 (class 0 OID 16483)
-- Dependencies: 216
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.players (player_id, name, surname, "position", contract_ends, image, statistics_id, injury_id) FROM stdin;
14	Rafael	Leao	Winger	2024-05-25	../../public/images/leao.png	\N	9
15	Oliver	Giroud	Striker	2024-05-25	../../public/images/giroud.png	\N	11
16	Theo	Hernandez	Left Back	2024-05-31	../../public/images/theo.png	\N	\N
\.


--
-- TOC entry 3401 (class 0 OID 16507)
-- Dependencies: 219
-- Data for Name: statistics; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.statistics (statistics_id, player_id, goals, assists, passes_completed, distance_covered, fouls, yellow_cards, red_cards, shots_on_target, saves, feedback) FROM stdin;
\.


--
-- TOC entry 3399 (class 0 OID 16491)
-- Dependencies: 217
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.users (username, password, role, player_id, changed_password) FROM stdin;
coach@milano.com	P@ssw0rd123!	coach	\N	t
rafaelleao@milano.com	milano123!!@	player	14	t
olivergiroud@milano.com	aaa123!!@	player	15	t
theohernandez@milano.com	default	player	16	f
\.


--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 220
-- Name: injuries_injury_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.injuries_injury_id_seq', 11, true);


--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 215
-- Name: players_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.players_player_id_seq', 16, true);


--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 218
-- Name: statistics_statistics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.statistics_statistics_id_seq', 1, false);


--
-- TOC entry 3242 (class 2606 OID 16539)
-- Name: injuries injuries_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (injury_id);


--
-- TOC entry 3244 (class 2606 OID 16541)
-- Name: injuries injuries_player_id_key; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.injuries
    ADD CONSTRAINT injuries_player_id_key UNIQUE (player_id);


--
-- TOC entry 3234 (class 2606 OID 16490)
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (player_id);


--
-- TOC entry 3238 (class 2606 OID 16523)
-- Name: statistics statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.statistics
    ADD CONSTRAINT statistics_pkey PRIMARY KEY (statistics_id);


--
-- TOC entry 3240 (class 2606 OID 16525)
-- Name: statistics statistics_player_id_key; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.statistics
    ADD CONSTRAINT statistics_player_id_key UNIQUE (player_id);


--
-- TOC entry 3236 (class 2606 OID 16499)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- TOC entry 3253 (class 2620 OID 16566)
-- Name: injuries after_injury_insert; Type: TRIGGER; Schema: public; Owner: docker
--

CREATE TRIGGER after_injury_insert AFTER INSERT ON public.injuries FOR EACH ROW EXECUTE FUNCTION public.update_player_with_injury();


--
-- TOC entry 3252 (class 2620 OID 16562)
-- Name: players after_player_insert; Type: TRIGGER; Schema: public; Owner: docker
--

CREATE TRIGGER after_player_insert AFTER INSERT ON public.players FOR EACH ROW EXECUTE FUNCTION public.add_player_to_users();


--
-- TOC entry 3245 (class 2606 OID 16584)
-- Name: players fk_injury; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT fk_injury FOREIGN KEY (injury_id) REFERENCES public.injuries(injury_id) ON DELETE SET NULL;


--
-- TOC entry 3250 (class 2606 OID 16577)
-- Name: injuries fk_player; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.injuries
    ADD CONSTRAINT fk_player FOREIGN KEY (player_id) REFERENCES public.players(player_id) ON DELETE CASCADE;


--
-- TOC entry 3251 (class 2606 OID 16542)
-- Name: injuries injuries_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.injuries
    ADD CONSTRAINT injuries_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id);


--
-- TOC entry 3246 (class 2606 OID 16552)
-- Name: players players_injury_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_injury_id_fkey FOREIGN KEY (injury_id) REFERENCES public.injuries(injury_id);


--
-- TOC entry 3247 (class 2606 OID 16547)
-- Name: players players_statistics_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_statistics_id_fkey FOREIGN KEY (statistics_id) REFERENCES public.statistics(statistics_id);


--
-- TOC entry 3249 (class 2606 OID 16526)
-- Name: statistics statistics_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.statistics
    ADD CONSTRAINT statistics_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id);


--
-- TOC entry 3248 (class 2606 OID 16500)
-- Name: users users_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id);


-- Completed on 2024-05-25 11:55:40 UTC

--
-- PostgreSQL database dump complete
--

