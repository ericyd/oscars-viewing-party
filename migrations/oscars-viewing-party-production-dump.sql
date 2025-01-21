--
-- PostgreSQL database dump
--

-- Dumped from database version 15.6
-- Dumped by pg_dump version 15.5 (Debian 15.5-1.pgdg120+1)

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
-- Name: atlas_schema_revisions; Type: SCHEMA; Schema: -; Owner: oscars_viewing_party_user
--

CREATE SCHEMA atlas_schema_revisions;


ALTER SCHEMA atlas_schema_revisions OWNER TO oscars_viewing_party_user;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: oscars_viewing_party_user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO oscars_viewing_party_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: atlas_schema_revisions; Type: TABLE; Schema: atlas_schema_revisions; Owner: oscars_viewing_party_user
--

CREATE TABLE atlas_schema_revisions.atlas_schema_revisions (
    version character varying NOT NULL,
    description character varying NOT NULL,
    type bigint DEFAULT 2 NOT NULL,
    applied bigint DEFAULT 0 NOT NULL,
    total bigint DEFAULT 0 NOT NULL,
    executed_at timestamp with time zone NOT NULL,
    execution_time bigint NOT NULL,
    error text,
    error_stmt text,
    hash character varying NOT NULL,
    partial_hashes jsonb,
    operator_version character varying NOT NULL
);


ALTER TABLE atlas_schema_revisions.atlas_schema_revisions OWNER TO oscars_viewing_party_user;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: oscars_viewing_party_user
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    category text NOT NULL,
    meta_category text
);


ALTER TABLE public.categories OWNER TO oscars_viewing_party_user;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: oscars_viewing_party_user
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO oscars_viewing_party_user;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: oscars_viewing_party_user
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: even_dist_sequence; Type: SEQUENCE; Schema: public; Owner: oscars_viewing_party_user
--

CREATE SEQUENCE public.even_dist_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE;


ALTER TABLE public.even_dist_sequence OWNER TO oscars_viewing_party_user;

--
-- Name: nominees; Type: TABLE; Schema: public; Owner: oscars_viewing_party_user
--

CREATE TABLE public.nominees (
    id integer NOT NULL,
    nominee text NOT NULL,
    artwork text NOT NULL,
    category_id integer NOT NULL,
    winner boolean DEFAULT false NOT NULL,
    year integer DEFAULT 2024 NOT NULL
);


ALTER TABLE public.nominees OWNER TO oscars_viewing_party_user;

--
-- Name: nominees_id_seq; Type: SEQUENCE; Schema: public; Owner: oscars_viewing_party_user
--

CREATE SEQUENCE public.nominees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nominees_id_seq OWNER TO oscars_viewing_party_user;

--
-- Name: nominees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: oscars_viewing_party_user
--

ALTER SEQUENCE public.nominees_id_seq OWNED BY public.nominees.id;


--
-- Name: predictions; Type: TABLE; Schema: public; Owner: oscars_viewing_party_user
--

CREATE TABLE public.predictions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    nominee_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.predictions OWNER TO oscars_viewing_party_user;

--
-- Name: predictions_id_seq; Type: SEQUENCE; Schema: public; Owner: oscars_viewing_party_user
--

CREATE SEQUENCE public.predictions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.predictions_id_seq OWNER TO oscars_viewing_party_user;

--
-- Name: predictions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: oscars_viewing_party_user
--

ALTER SEQUENCE public.predictions_id_seq OWNED BY public.predictions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: oscars_viewing_party_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    username text NOT NULL,
    room_id text NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    year integer DEFAULT 2024 NOT NULL
);


ALTER TABLE public.users OWNER TO oscars_viewing_party_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: oscars_viewing_party_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO oscars_viewing_party_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: oscars_viewing_party_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: oscars_viewing_party_user
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: nominees id; Type: DEFAULT; Schema: public; Owner: oscars_viewing_party_user
--

ALTER TABLE ONLY public.nominees ALTER COLUMN id SET DEFAULT nextval('public.nominees_id_seq'::regclass);


--
-- Name: predictions id; Type: DEFAULT; Schema: public; Owner: oscars_viewing_party_user
--

ALTER TABLE ONLY public.predictions ALTER COLUMN id SET DEFAULT nextval('public.predictions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: oscars_viewing_party_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: atlas_schema_revisions; Type: TABLE DATA; Schema: atlas_schema_revisions; Owner: oscars_viewing_party_user
--

COPY atlas_schema_revisions.atlas_schema_revisions (version, description, type, applied, total, executed_at, execution_time, error, error_stmt, hash, partial_hashes, operator_version) FROM stdin;
20240208014006	full_schema	2	9	9	2024-02-11 23:17:16.837323+00	111787208			a35P5bR1rmYIo4AjR1RyoiSPUioHp0hlQrxmGapntAs=	["h1:eUNSsXU2FLX4PfhjnRuw0O5kieubku++9MnHymaDHQo=", "h1:cr9e4z/XmO0FsIp7BgxLPIbLE3ZaelQgcA5cRjsO8Pw=", "h1:H5l3hmE4/qCJXFJ0YEs25BPnpm98ijVhMFKmgSoTz00=", "h1:++UF59BFKyjyPcFbU91sfzwYLzxB9CgQWlTAIaeAefs=", "h1:4KsFRlkCbvUqA1W97YPrzxwmndkYLpHHjY81HGLUM20=", "h1:oFmsFEMLSKeIPVhMsog9mHtcMPWLvK/yAbuYYdfu+3w=", "h1:R/wg4MQUrKvrCPvzgyff70YHFUiUxJXzIPqnd5ttWR8=", "h1:co6bzpl/8+/bXE6nKku8TkKQi3RU6JWn069Hxfl3wKE=", "h1:kmTeh4g3uxkfDabYle+Xb/I0g5+r8LPkbm7/EcAmR+s="]	Atlas CLI v0.19.1-cb5c5d4-canary
20240208024216	insert_categories	2	23	23	2024-02-11 23:17:19.122594+00	111995167			ueYWYgy4SC9LoplO8aLeLUOdM9drzBNFRNbYZfu2kHE=	["h1:zNBUXxvnyp/Tpbi2x7GZzM/kOV7CyMtqnjBzwmCknSc=", "h1:vvc9gEcv8/nhYkrtC97dwR2qgIY5+WF+AgCcSgTAgI4=", "h1:dPgmyP580SNWKTqo6dGAw8Xk+S1NN8Kdq8Y4FtKitdI=", "h1:AFawgOEtiWXwylfIc739CPvX5Ujm+RugUwI+Uyqmhds=", "h1:nOqju5h7PNMBE7qN4ipl1mE4ELD6mz/RmqMvvUhaS7M=", "h1:95b13nhgocSTlQIK1NQRU04QMRgg01sPVjl8uJ/zl+c=", "h1:nKsyId1QSi2nWKg6ogueiEzpVjhbmLWR6KgAkVtK3OI=", "h1:AdcvGON6gmhspRxcEYZAC/S/z5wHQzuihAInEpIPTzQ=", "h1:SXV26h5be2Q7w80bUt4dVIR4YfhAtrr8yaBmMs/N05Y=", "h1:EemAqBHOI4eauLbvP+pUdWNaq8AFGKamiP4NNZpKxeY=", "h1:8KFXXGkGnqyzXuKPAWB5OBB4R3SWxsngHCmisZArDG8=", "h1:YVEARK5kw/Q0i2RA+3/BEy7KhpqkZoKBP6luOwjZAMA=", "h1:brWsORhT0AjjGsuSjxQBIvzRRCeCqs7nS8Jda/J38+g=", "h1:Dj8nZx3+2L4PpP76K7WxNFuUN+8FHvuj/xpZNo6xGh8=", "h1:tnuEjLl/Sw02OZitmOJ69Vjl/A09uJhFgZJfRFuuxJo=", "h1:0KCYChNsZHXaFanQFbFEo6vptQUi5Z/McqddnaHZGyY=", "h1:Pw4xe2tV1M6+wy+cq3d3HSlxKHbzcO3p7PALBqJU89Y=", "h1:RVjr52Wn0UPVLai+myeFgN4MhGidWH+60QlSKEz+NKM=", "h1:8JVinDwxI1p+AHHKfYoLgm0C+1SUaz7hiTvaG+i7rGI=", "h1:9WJGWvpNC5yoJWPQoZ1/85AetCK9x+jv229IM13hGFE=", "h1:ykq1gOUKmWPM/usiYpTV7p5zSYeX7UEfMLU+Ux6zlp0=", "h1:rT7D16TsNEyEwUrz6YgrI0r94r8q2BfMnLCvwhoaWwY=", "h1:GVXyETyHVf9pWJtbV0EYYKOLaHfn8dm7tLvzn8KrK3E="]	Atlas CLI v0.19.1-cb5c5d4-canary
20240211233622	drop_rooms	2	2	2	2024-02-11 23:40:44.965626+00	121581458			Jf29enjCBsMenyZAPPvuRaLuC8P9EO9iigGoLVU1nGo=	["h1:kpmhq+fMd1/5WFcGlhowRqPiyG6jRpuqnubmtnwEY1c=", "h1:fCpoZsSNhOlwg4L9viEbIbJfH7kqL4OvX3SXqf9sbOI="]	Atlas CLI v0.19.1-cb5c5d4-canary
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: oscars_viewing_party_user
--

COPY public.categories (id, category, meta_category) FROM stdin;
1	Best Picture	Overall
2	Actor in a Leading Role	Acting
3	Actor in a Supporting Role	Acting
4	Actress in a Leading Role	Acting
5	Actress in a Supporting Role	Acting
6	Animated Feature Film	Features
7	Cinematography	Overall
8	Costume Design	Visuals
9	Directing	Overall
10	Documentary Feature	Features
11	Documentary Short	Shorts
12	Film Editing	Overall
13	International Feature Film	Features
14	Makeup and Hairstyling	Visuals
15	Original Score	Sound
16	Original Song	Sound
17	Production Design	Visuals
18	Animated Short Film	Shorts
19	Live Action Short Film	Shorts
20	Best Sound	Sound
21	Visual Effects	Visuals
22	Adapted Screenplay	Writing
23	Original Screenplay	Writing
\.


--
-- Data for Name: nominees; Type: TABLE DATA; Schema: public; Owner: oscars_viewing_party_user
--

COPY public.nominees (id, nominee, artwork, category_id, winner, year) FROM stdin;
26	Emily Blunt	Oppenheimer	5	f	2024
71	Karen Hartley Thomas, Suzi Battersby and Ashra Kelly-Blue	Golda	14	f	2024
32	Peter Sohn and Denise Ream	Elemental	6	f	2024
33	Nick Bruno, Troy Quane, Karen Ryan and Julie Zackary	Nimona	6	f	2024
31	Hayao Miyazaki and Toshio Suzuki	The Boy And The Heron	6	t	2024
72	Kazu Hiro, Kay Georgiou and Lori McCoy-Bell	Maestro	14	f	2024
73	Luisa Abel	Oppenheimer	14	f	2024
86	Production Design: Sarah Greenwood; Set Decoration: Katie Spencer	Barbie	17	f	2024
75	Ana López-Puigcerver, David Martí and Montse Ribé	Society Of The Snow	14	f	2024
74	Nadia Stacey, Mark Coulier and Josh Weston	Poor Things	14	t	2024
87	Production Design: Jack Fisk; Set Decoration: Adam Willis	Killers Of The Flower Moon	17	f	2024
45	Holly Waddington	Poor Things	8	t	2024
66	Italy	Io Capitano	13	f	2024
67	Japan	Perfect Days	13	f	2024
68	Spain	Society Of The Snow	13	f	2024
41	Jacqueline Durran	Barbie	8	f	2024
42	Jacqueline West	Killers Of The Flower Moon	8	f	2024
43	Janty Yates and Dave Crossman	Napoleon	8	f	2024
44	Ellen Mirojnick	Oppenheimer	8	f	2024
69	Germany	The Teachers' Lounge	13	f	2024
16	Sterling K. Brown	American Fiction	3	f	2024
70	United Kingdom	The Zone Of Interest	13	t	2024
17	Robert De Niro	Killers Of The Flower Moon	3	f	2024
61	Laurent Sénéchal	Anatomy Of A Fall	12	f	2024
19	Ryan Gosling	Barbie	3	f	2024
20	Mark Ruffalo	Poor Things	3	f	2024
18	Robert Downey Jr.	Oppenheimer	3	t	2024
62	Kevin Tent	The Holdovers	12	f	2024
63	Thelma Schoonmaker	Killers Of The Flower Moon	12	f	2024
56	Sheila Nevins and Trish Adlesic	The Abcs Of Book Banning	11	f	2024
65	Yorgos Mavropsaridis	Poor Things	12	f	2024
64	Jennifer Lame	Oppenheimer	12	t	2024
57	John Hoffman and Christine Turner	The Barber Of Little Rock	11	f	2024
58	S. Leo Chiang and Jean Tsien	Island In Between	11	f	2024
51	Moses Bwayo, Christopher Sharp and John Battsek	Bobi Wine: The People's President	10	f	2024
60	Sean Wang and Sam Davis	Nǎi Nai & Wài Pó	11	f	2024
59	Ben Proudfoot and Kris Bowers	The Last Repair Shop	11	t	2024
52	Nominees to be determined	The Eternal Memory	10	f	2024
53	Kaouther Ben Hania and Nadim Cheikhrouha	Four Daughters	10	f	2024
54	Nisha Pahuja, Cornelia Principe and David Oppenheim	To Kill A Tiger	10	f	2024
36	Edward Lachman	El Conde	7	f	2024
37	Rodrigo Prieto	Killers Of The Flower Moon	7	f	2024
38	Matthew Libatique	Maestro	7	f	2024
76	Laura Karpman	American Fiction	15	f	2024
40	Robbie Ryan	Poor Things	7	f	2024
39	Hoyte van Hoytema	Oppenheimer	7	t	2024
77	John Williams	Indiana Jones And The Dial Of Destiny	15	f	2024
78	Robbie Robertson	Killers Of The Flower Moon	15	f	2024
81	Diane Warren	"The Fire Inside" from Flamin' Hot	16	f	2024
80	Jerskin Fendrix	Poor Things	15	f	2024
79	Ludwig Göransson	Oppenheimer	15	t	2024
82	Mark Ronson and Andrew Wyatt	"I'm Just Ken" from Barbie	16	f	2024
83	Jon Batiste and Dan Wilson	"It Never Went Away" from American Symphony	16	f	2024
84	Scott George	"Wahzhazhe (A Song For My People)" from Killers Of The Flower Moon	16	f	2024
11	Bradley Cooper	Maestro	2	f	2024
85	Billie Eilish and Finneas O'Connell	"What Was I Made For?" from Barbie	16	t	2024
12	Colman Domingo	Rustin	2	f	2024
13	Paul Giamatti	The Holdovers	2	f	2024
46	Justine Triet	Anatomy Of A Fall	9	f	2024
15	Jeffrey Wright	American Fiction	2	f	2024
14	Cillian Murphy	Oppenheimer	2	t	2024
47	Martin Scorsese	Killers Of The Flower Moon	9	f	2024
21	Annette Bening	Nyad	4	f	2024
49	Yorgos Lanthimos	Poor Things	9	f	2024
50	Jonathan Glazer	The Zone Of Interest	9	f	2024
48	Christopher Nolan	Oppenheimer	9	t	2024
22	Lily Gladstone	Killers Of The Flower Moon	4	f	2024
23	Sandra Hüller	Anatomy Of A Fall	4	f	2024
24	Carey Mulligan	Maestro	4	f	2024
1	Ben LeClair, Nikos Karamigios, Cord Jefferson and Jermaine Johnson, Producers	American Fiction	1	f	2024
25	Emma Stone	Poor Things	4	t	2024
2	Marie-Ange Luciani and David Thion, Producers	Anatomy Of A Fall	1	f	2024
3	David Heyman, Margot Robbie, Tom Ackerley and Robbie Brenner, Producers	Barbie	1	f	2024
4	Mark Johnson, Producer	The Holdovers	1	f	2024
116	Screenplay - Justine Triet and Arthur Harari	Anatomy Of A Fall	23	t	2024
100	Wes Anderson and Steven Rales	The Wonderful Story Of Henry Sugar	19	t	2024
101	Ian Voigt, Erik Aadahl, Ethan Van der Ryn, Tom Ozanich and Dean Zupancic	The Creator	20	f	2024
27	Danielle Brooks	The Color Purple	5	f	2024
28	America Ferrera	Barbie	5	f	2024
29	Jodie Foster	Nyad	5	f	2024
30	Da'Vine Joy Randolph	The Holdovers	5	t	2024
102	Steven A. Morrow, Richard King, Jason Ruder, Tom Ozanich and Dean Zupancic	Maestro	20	f	2024
103	Chris Munro, James H. Mather, Chris Burdon and Mark Taylor	Mission: Impossible - Dead Reckoning Part One	20	f	2024
104	Willie Burton, Richard King, Gary A. Rizzo and Kevin O'Connell	Oppenheimer	20	f	2024
112	Written by Greta Gerwig & Noah Baumbach	Barbie	22	f	2024
113	Written for the screen by Christopher Nolan	Oppenheimer	22	f	2024
114	Screenplay by Tony McNamara	Poor Things	22	f	2024
115	Written by Jonathan Glazer	The Zone Of Interest	22	f	2024
91	Tal Kantor and Amit R. Gicelter	Letter To A Pig	18	f	2024
92	Jerusha Hess and Jared Hess	Ninety-Five Senses	18	f	2024
93	Yegane Moghaddam	Our Uniform	18	f	2024
94	Stéphanie Clément and Marc Rius	Pachyderme	18	f	2024
95	Dave Mullins and Brad Booker	War Is Over! Inspired By The Music Of John & Yoko	18	t	2024
34	Pablo Berger, Ibon Cormenzana, Ignasi Estapé and Sandra Tapia Díaz	Robot Dreams	6	f	2024
35	Kemp Powers, Justin K. Thompson, Phil Lord, Christopher Miller and Amy Pascal	Spider-Man: Across The Spider-Verse	6	f	2024
117	Written by David Hemingson	The Holdovers	23	f	2024
118	Written by Bradley Cooper & Josh Singer	Maestro	23	f	2024
119	Screenplay by Samy Burch; Story by Samy Burch & Alex Mechanik	May December	23	f	2024
120	Written by Celine Song	Past Lives	23	f	2024
111	Written for the screen by Cord Jefferson	American Fiction	22	t	2024
88	Production Design: Arthur Max; Set Decoration: Elli Griff	Napoleon	17	f	2024
89	Production Design: Ruth De Jong; Set Decoration: Claire Kaufman	Oppenheimer	17	f	2024
105	Tarn Willers and Johnnie Burn	The Zone Of Interest	20	t	2024
90	Production Design: James Price and Shona Heath; Set Decoration: Zsuzsa Mihalek	Poor Things	17	t	2024
106	Jay Cooper, Ian Comley, Andrew Roberts and Neil Corbould	The Creator	21	f	2024
5	Dan Friedkin, Bradley Thomas, Martin Scorsese and Daniel Lupi, Producers	Killers Of The Flower Moon	1	f	2024
108	Stephane Ceretti, Alexis Wajsbrot, Guy Williams and Theo Bialek	Guardians Of The Galaxy Vol. 3	21	f	2024
109	Alex Wuttke, Simone Coco, Jeff Sutherland and Neil Corbould	Mission: Impossible - Dead Reckoning Part One	21	f	2024
110	Charley Henley, Luc-Ewen Martin-Fenouillet, Simone Coco and Neil Corbould	Napoleon	21	f	2024
107	Takashi Yamazaki, Kiyoko Shibuya, Masaki Takahashi and Tatsuji Nojima	Godzilla Minus One	21	t	2024
55	Mstyslav Chernov, Michelle Mizner and Raney Aronson-Rath	20 Days In Mariupol	10	t	2024
96	Misan Harriman and Nicky Bentham	The After	19	f	2024
97	Vincent René-Lortie and Samuel Caron	Invincible	19	f	2024
98	Lasse Lyskjær Noer and Christian Norlyk	Knight Of Fortune	19	f	2024
99	Nazrin Choudhury and Sara McFarlane	Red, White And Blue	19	f	2024
6	Bradley Cooper, Steven Spielberg, Fred Berner, Amy Durning and Kristie Macosko Krieger, Producers	Maestro	1	f	2024
8	David Hinojosa, Christine Vachon and Pamela Koffler, Producers	Past Lives	1	f	2024
9	Ed Guiney, Andrew Lowe, Yorgos Lanthimos and Emma Stone, Producers	Poor Things	1	f	2024
10	James Wilson, Producer	The Zone Of Interest	1	f	2024
7	Emma Thomas, Charles Roven and Christopher Nolan, Producers	Oppenheimer	1	t	2024
\.


--
-- Data for Name: predictions; Type: TABLE DATA; Schema: public; Owner: oscars_viewing_party_user
--

COPY public.predictions (id, user_id, nominee_id, category_id) FROM stdin;
1	1	5	1
2	1	12	2
3	1	16	3
4	1	22	4
5	3	14	2
6	3	16	3
7	3	21	4
8	3	26	5
9	3	31	6
10	3	54	10
11	3	70	13
12	4	7	1
13	4	14	2
14	4	18	3
15	4	22	4
16	4	30	5
17	4	31	6
18	4	39	7
19	4	45	8
20	4	48	9
21	4	55	10
22	4	56	11
23	4	64	12
24	4	70	13
25	4	74	14
26	4	79	15
27	4	82	16
28	4	90	17
29	4	95	18
30	4	99	19
31	4	104	20
32	4	107	21
33	4	113	22
34	4	117	23
58	5	7	1
59	5	12	2
60	5	19	3
61	5	24	4
62	5	26	5
63	5	35	6
64	5	39	7
65	5	44	8
66	5	48	9
67	5	53	10
68	5	60	11
69	5	64	12
70	5	68	13
71	5	73	14
72	5	78	15
73	5	83	16
74	5	86	17
75	5	95	18
76	5	97	19
77	5	104	20
78	5	109	21
79	5	113	22
80	5	116	23
81	6	3	1
82	6	14	2
83	6	19	3
84	6	25	4
85	6	26	5
86	6	32	6
87	6	39	7
88	6	41	8
89	6	47	9
90	6	55	10
91	6	57	11
92	6	64	12
93	6	66	13
94	6	75	14
95	6	76	15
96	6	82	16
97	6	89	17
98	6	95	18
99	6	97	19
100	6	104	20
101	6	107	21
102	6	113	22
103	6	116	23
104	7	7	1
105	7	19	3
106	7	24	4
107	7	30	5
108	7	35	6
109	7	39	7
110	7	48	9
111	7	65	12
112	7	70	13
113	7	80	15
114	7	93	18
115	7	98	19
133	8	4	1
134	8	14	2
135	8	18	3
136	8	22	4
137	8	30	5
138	8	35	6
139	8	40	7
140	8	45	8
141	8	48	9
142	8	53	10
143	8	60	11
144	8	65	12
145	8	70	13
146	8	74	14
147	8	79	15
148	8	85	16
149	8	86	17
150	8	94	18
151	8	98	19
152	8	105	20
153	8	107	21
154	8	112	22
155	8	117	23
156	9	7	1
157	9	14	2
158	9	18	3
159	9	22	4
160	9	30	5
161	9	35	6
162	9	40	7
163	9	45	8
164	9	48	9
165	9	55	10
166	9	58	11
167	9	65	12
168	9	70	13
169	9	74	14
170	9	78	15
171	9	84	16
172	9	90	17
173	9	91	18
174	9	100	19
175	9	104	20
176	9	107	21
177	9	111	22
178	9	116	23
116	2	8	1
118	2	19	3
205	3	8	1
206	3	36	7
121	2	31	6
185	2	36	7
122	2	41	8
187	2	47	9
123	2	53	10
189	2	56	11
190	2	62	12
124	2	70	13
125	2	74	14
126	2	79	15
127	2	82	16
128	2	86	17
196	2	94	18
197	2	100	19
129	2	103	20
130	2	107	21
131	2	115	22
132	2	120	23
207	3	47	9
120	2	28	5
119	2	22	4
208	3	62	12
209	3	56	11
210	3	91	18
211	3	100	19
212	3	76	15
213	3	84	16
214	3	103	20
215	3	41	8
216	3	71	14
217	3	86	17
218	3	107	21
219	3	111	22
220	3	120	23
221	13	120	23
224	13	90	17
225	13	45	8
117	2	13	2
227	13	85	16
229	13	79	15
230	13	100	19
231	13	94	18
233	13	61	12
234	13	50	9
235	13	40	7
236	13	9	1
237	13	67	13
240	13	26	5
241	13	22	4
242	13	20	3
243	13	13	2
247	14	28	5
248	14	35	6
249	14	53	10
250	14	70	13
251	14	8	1
252	14	39	7
253	14	46	9
254	14	62	12
255	14	57	11
256	14	91	18
257	14	96	19
258	14	76	15
259	14	85	16
260	14	103	20
261	14	41	8
262	14	74	14
263	14	86	17
264	14	107	21
265	14	111	22
266	14	120	23
267	15	13	2
268	15	18	3
270	15	22	4
271	15	30	5
272	15	31	6
273	15	53	10
274	15	67	13
275	15	8	1
276	15	39	7
277	15	46	9
278	15	64	12
279	15	58	11
280	15	94	18
281	15	99	19
282	15	79	15
283	15	85	16
285	15	104	20
286	15	45	8
287	15	71	14
288	15	86	17
289	15	106	21
290	15	113	22
291	15	120	23
293	16	14	2
294	16	18	3
295	16	22	4
296	16	28	5
297	16	31	6
298	16	55	10
299	16	66	13
300	16	7	1
301	16	40	7
302	16	47	9
303	16	64	12
304	16	56	11
305	16	91	18
306	16	100	19
307	16	78	15
308	16	84	16
309	16	104	20
310	16	43	8
311	16	74	14
312	16	86	17
313	16	106	21
314	16	113	22
315	16	118	23
316	17	14	2
317	17	17	3
318	17	25	4
319	17	30	5
320	17	35	6
321	17	55	10
322	17	70	13
323	17	7	1
324	17	39	7
325	17	48	9
326	17	64	12
328	17	95	18
329	17	100	19
330	17	79	15
331	17	104	20
332	17	82	16
333	17	41	8
335	17	90	17
336	17	110	21
337	17	111	22
338	17	116	23
334	17	74	14
327	17	59	11
341	18	14	2
342	18	18	3
343	18	22	4
344	18	30	5
345	19	14	2
346	18	35	6
347	19	20	3
348	18	55	10
349	18	70	13
351	18	7	1
350	19	23	4
353	18	39	7
354	18	48	9
355	18	64	12
356	19	29	5
357	18	59	11
358	19	31	6
359	18	95	18
360	18	100	19
362	18	79	15
400	12	38	7
361	19	54	10
365	18	82	16
367	18	104	20
368	18	45	8
369	18	74	14
370	19	8	1
371	18	90	17
372	18	107	21
373	19	39	7
374	19	48	9
375	19	62	12
376	18	112	22
377	19	59	11
378	18	120	23
379	19	91	18
380	19	100	19
381	19	79	15
382	19	85	16
383	19	105	20
384	19	41	8
385	19	72	14
386	19	86	17
387	19	110	21
388	19	114	22
389	19	120	23
390	12	13	2
391	12	19	3
393	12	22	4
394	12	26	5
395	12	31	6
397	12	55	10
398	12	70	13
399	12	7	1
366	19	70	13
402	12	48	9
403	12	64	12
404	12	59	11
405	12	94	18
406	12	98	19
407	12	78	15
408	12	85	16
409	12	102	20
410	12	41	8
244	14	13	2
413	12	73	14
414	12	86	17
415	12	108	21
416	12	112	22
417	12	118	23
245	14	19	3
246	14	23	4
421	7	13	2
422	7	54	10
423	7	60	11
424	7	104	20
420	7	85	16
427	7	109	21
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: oscars_viewing_party_user
--

COPY public.users (id, name, username, room_id, admin, year) FROM stdin;
3	Eric Dauenhauer	ericydauenhauer	ap2024	f	2024
4	Andrew Bailey	andrewbailey404	ap2024	f	2024
5	Christopher W.	CMW	ap2024	f	2024
6	Stefania Vichi	Stefi V.	ap2024	f	2024
2	Eric	ericydauenhauer	salami-productions-2024	f	2024
7	Unrequitedloofah 	Uses ssn as pw	salami-productions-2024	f	2024
8	Salami	VerifiedSalami88	salami-productions-2024	f	2024
9	rachel	rainbowspice	salami-productions-2024	f	2024
1	eric d	tortilla chip 2024	eric-admin-room	t	2024
12	Betty	Betty	salami-productions-2024	f	2024
13	Margaret	1234	salami-productions-2024	f	2024
14	Patricia	Pattyromero4@gmail.com	salami-productions-2024	f	2024
15	Alyssa	AlyssaI	salami-productions-2024	f	2024
16	Magda	Magda	salami-productions-2024	f	2024
17	Matt 	beckywiththegoodhair	salami-productions-2024	f	2024
18	Lizzy	Lizzy	salami-productions-2024	f	2024
19	Warner Cook	WCook	salami-productions-2024	f	2024
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: oscars_viewing_party_user
--

SELECT pg_catalog.setval('public.categories_id_seq', 23, true);


--
-- Name: even_dist_sequence; Type: SEQUENCE SET; Schema: public; Owner: oscars_viewing_party_user
--

SELECT pg_catalog.setval('public.even_dist_sequence', 35, true);


--
-- Name: nominees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: oscars_viewing_party_user
--

SELECT pg_catalog.setval('public.nominees_id_seq', 120, true);


--
-- Name: predictions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: oscars_viewing_party_user
--

SELECT pg_catalog.setval('public.predictions_id_seq', 427, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: oscars_viewing_party_user
--

SELECT pg_catalog.setval('public.users_id_seq', 19, true);


--
-- Name: atlas_schema_revisions atlas_schema_revisions_pkey; Type: CONSTRAINT; Schema: atlas_schema_revisions; Owner: oscars_viewing_party_user
--

ALTER TABLE ONLY atlas_schema_revisions.atlas_schema_revisions
    ADD CONSTRAINT atlas_schema_revisions_pkey PRIMARY KEY (version);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: oscars_viewing_party_user
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: nominees nominees_pkey; Type: CONSTRAINT; Schema: public; Owner: oscars_viewing_party_user
--

ALTER TABLE ONLY public.nominees
    ADD CONSTRAINT nominees_pkey PRIMARY KEY (id);


--
-- Name: predictions predictions_pkey; Type: CONSTRAINT; Schema: public; Owner: oscars_viewing_party_user
--

ALTER TABLE ONLY public.predictions
    ADD CONSTRAINT predictions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: oscars_viewing_party_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_unique_room_id_name; Type: INDEX; Schema: public; Owner: oscars_viewing_party_user
--

CREATE UNIQUE INDEX index_unique_room_id_name ON public.users USING btree (name, room_id) NULLS NOT DISTINCT;


--
-- Name: index_unique_room_id_username; Type: INDEX; Schema: public; Owner: oscars_viewing_party_user
--

CREATE UNIQUE INDEX index_unique_room_id_username ON public.users USING btree (username, room_id) NULLS NOT DISTINCT;


--
-- Name: index_unique_user_id_category_id; Type: INDEX; Schema: public; Owner: oscars_viewing_party_user
--

CREATE UNIQUE INDEX index_unique_user_id_category_id ON public.predictions USING btree (user_id, category_id) NULLS NOT DISTINCT;


--
-- Name: index_unique_winner_year_category_id; Type: INDEX; Schema: public; Owner: oscars_viewing_party_user
--

CREATE UNIQUE INDEX index_unique_winner_year_category_id ON public.nominees USING btree (winner, year, category_id) NULLS NOT DISTINCT WHERE (winner = true);


--
-- Name: nominees category_id; Type: FK CONSTRAINT; Schema: public; Owner: oscars_viewing_party_user
--

ALTER TABLE ONLY public.nominees
    ADD CONSTRAINT category_id FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: predictions category_id; Type: FK CONSTRAINT; Schema: public; Owner: oscars_viewing_party_user
--

ALTER TABLE ONLY public.predictions
    ADD CONSTRAINT category_id FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: predictions nominee_id; Type: FK CONSTRAINT; Schema: public; Owner: oscars_viewing_party_user
--

ALTER TABLE ONLY public.predictions
    ADD CONSTRAINT nominee_id FOREIGN KEY (nominee_id) REFERENCES public.nominees(id) ON DELETE CASCADE;


--
-- Name: predictions user_id; Type: FK CONSTRAINT; Schema: public; Owner: oscars_viewing_party_user
--

ALTER TABLE ONLY public.predictions
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES  TO oscars_viewing_party_user;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES  TO oscars_viewing_party_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS  TO oscars_viewing_party_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO oscars_viewing_party_user;


--
-- PostgreSQL database dump complete
--

