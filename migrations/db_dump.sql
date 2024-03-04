--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5 (Debian 15.5-1.pgdg120+1)
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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    category text NOT NULL,
    meta_category text
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: nominees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nominees (
    id integer NOT NULL,
    nominee text NOT NULL,
    artwork text NOT NULL,
    category_id integer NOT NULL,
    winner boolean DEFAULT false NOT NULL,
    year integer DEFAULT 2024 NOT NULL
);


ALTER TABLE public.nominees OWNER TO postgres;

--
-- Name: nominees_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nominees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nominees_id_seq OWNER TO postgres;

--
-- Name: nominees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nominees_id_seq OWNED BY public.nominees.id;


--
-- Name: predictions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.predictions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    nominee_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.predictions OWNER TO postgres;

--
-- Name: predictions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.predictions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.predictions_id_seq OWNER TO postgres;

--
-- Name: predictions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.predictions_id_seq OWNED BY public.predictions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    username text NOT NULL,
    room_id text NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    year integer DEFAULT 2024 NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: nominees id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nominees ALTER COLUMN id SET DEFAULT nextval('public.nominees_id_seq'::regclass);


--
-- Name: predictions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predictions ALTER COLUMN id SET DEFAULT nextval('public.predictions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- Data for Name: nominees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nominees (id, nominee, artwork, category_id, winner, year) FROM stdin;
1	Ben LeClair, Nikos Karamigios, Cord Jefferson and Jermaine Johnson, Producers	American Fiction	1	f	2024
2	Marie-Ange Luciani and David Thion, Producers	Anatomy Of A Fall	1	f	2024
3	David Heyman, Margot Robbie, Tom Ackerley and Robbie Brenner, Producers	Barbie	1	f	2024
4	Mark Johnson, Producer	The Holdovers	1	f	2024
5	Dan Friedkin, Bradley Thomas, Martin Scorsese and Daniel Lupi, Producers	Killers Of The Flower Moon	1	f	2024
7	Emma Thomas, Charles Roven and Christopher Nolan, Producers	Oppenheimer	1	f	2024
8	David Hinojosa, Christine Vachon and Pamela Koffler, Producers	Past Lives	1	f	2024
9	Ed Guiney, Andrew Lowe, Yorgos Lanthimos and Emma Stone, Producers	Poor Things	1	f	2024
10	James Wilson, Producer	The Zone Of Interest	1	f	2024
12	Colman Domingo	Rustin	2	f	2024
13	Paul Giamatti	The Holdovers	2	f	2024
14	Cillian Murphy	Oppenheimer	2	f	2024
15	Jeffrey Wright	American Fiction	2	f	2024
17	Robert De Niro	Killers Of The Flower Moon	3	f	2024
18	Robert Downey Jr.	Oppenheimer	3	f	2024
19	Ryan Gosling	Barbie	3	f	2024
20	Mark Ruffalo	Poor Things	3	f	2024
22	Lily Gladstone	Killers Of The Flower Moon	4	f	2024
23	Sandra Hüller	Anatomy Of A Fall	4	f	2024
24	Carey Mulligan	Maestro	4	f	2024
25	Emma Stone	Poor Things	4	f	2024
26	Emily Blunt	Oppenheimer	5	f	2024
28	America Ferrera	Barbie	5	f	2024
29	Jodie Foster	Nyad	5	f	2024
30	Da'Vine Joy Randolph	The Holdovers	5	f	2024
31	Hayao Miyazaki and Toshio Suzuki	The Boy And The Heron	6	f	2024
33	Nick Bruno, Troy Quane, Karen Ryan and Julie Zackary	Nimona	6	f	2024
34	Pablo Berger, Ibon Cormenzana, Ignasi Estapé and Sandra Tapia Díaz	Robot Dreams	6	f	2024
35	Kemp Powers, Justin K. Thompson, Phil Lord, Christopher Miller and Amy Pascal	Spider-Man: Across The Spider-Verse	6	f	2024
36	Edward Lachman	El Conde	7	f	2024
37	Rodrigo Prieto	Killers Of The Flower Moon	7	f	2024
38	Matthew Libatique	Maestro	7	f	2024
39	Hoyte van Hoytema	Oppenheimer	7	f	2024
40	Robbie Ryan	Poor Things	7	f	2024
41	Jacqueline Durran	Barbie	8	f	2024
42	Jacqueline West	Killers Of The Flower Moon	8	f	2024
43	Janty Yates and Dave Crossman	Napoleon	8	f	2024
44	Ellen Mirojnick	Oppenheimer	8	f	2024
45	Holly Waddington	Poor Things	8	f	2024
46	Justine Triet	Anatomy Of A Fall	9	f	2024
47	Martin Scorsese	Killers Of The Flower Moon	9	f	2024
48	Christopher Nolan	Oppenheimer	9	f	2024
49	Yorgos Lanthimos	Poor Things	9	f	2024
50	Jonathan Glazer	The Zone Of Interest	9	f	2024
51	Moses Bwayo, Christopher Sharp and John Battsek	Bobi Wine: The People's President	10	f	2024
52	Nominees to be determined	The Eternal Memory	10	f	2024
53	Kaouther Ben Hania and Nadim Cheikhrouha	Four Daughters	10	f	2024
54	Nisha Pahuja, Cornelia Principe and David Oppenheim	To Kill A Tiger	10	f	2024
55	Mstyslav Chernov, Michelle Mizner and Raney Aronson-Rath	20 Days In Mariupol	10	f	2024
56	Sheila Nevins and Trish Adlesic	The Abcs Of Book Banning	11	f	2024
57	John Hoffman and Christine Turner	The Barber Of Little Rock	11	f	2024
58	S. Leo Chiang and Jean Tsien	Island In Between	11	f	2024
59	Ben Proudfoot and Kris Bowers	The Last Repair Shop	11	f	2024
60	Sean Wang and Sam Davis	Nǎi Nai & Wài Pó	11	f	2024
61	Laurent Sénéchal	Anatomy Of A Fall	12	f	2024
62	Kevin Tent	The Holdovers	12	f	2024
63	Thelma Schoonmaker	Killers Of The Flower Moon	12	f	2024
64	Jennifer Lame	Oppenheimer	12	f	2024
65	Yorgos Mavropsaridis	Poor Things	12	f	2024
66	Italy	Io Capitano	13	f	2024
67	Japan	Perfect Days	13	f	2024
68	Spain	Society Of The Snow	13	f	2024
69	Germany	The Teachers' Lounge	13	f	2024
70	United Kingdom	The Zone Of Interest	13	f	2024
71	Karen Hartley Thomas, Suzi Battersby and Ashra Kelly-Blue	Golda	14	f	2024
72	Kazu Hiro, Kay Georgiou and Lori McCoy-Bell	Maestro	14	f	2024
73	Luisa Abel	Oppenheimer	14	f	2024
74	Nadia Stacey, Mark Coulier and Josh Weston	Poor Things	14	f	2024
75	Ana López-Puigcerver, David Martí and Montse Ribé	Society Of The Snow	14	f	2024
76	Laura Karpman	American Fiction	15	f	2024
77	John Williams	Indiana Jones And The Dial Of Destiny	15	f	2024
78	Robbie Robertson	Killers Of The Flower Moon	15	f	2024
79	Ludwig Göransson	Oppenheimer	15	f	2024
80	Jerskin Fendrix	Poor Things	15	f	2024
81	Diane Warren	"The Fire Inside" from Flamin' Hot	16	f	2024
82	Mark Ronson and Andrew Wyatt	"I'm Just Ken" from Barbie	16	f	2024
83	Jon Batiste and Dan Wilson	"It Never Went Away" from American Symphony	16	f	2024
84	Scott George	"Wahzhazhe (A Song For My People)" from Killers Of The Flower Moon	16	f	2024
85	Billie Eilish and Finneas O'Connell	"What Was I Made For?" from Barbie	16	f	2024
86	Production Design: Sarah Greenwood; Set Decoration: Katie Spencer	Barbie	17	f	2024
87	Production Design: Jack Fisk; Set Decoration: Adam Willis	Killers Of The Flower Moon	17	f	2024
16	Sterling K. Brown	American Fiction	3	f	2024
11	Bradley Cooper	Maestro	2	t	2024
21	Annette Bening	Nyad	4	f	2024
27	Danielle Brooks	The Color Purple	5	t	2024
32	Peter Sohn and Denise Ream	Elemental	6	t	2024
88	Production Design: Arthur Max; Set Decoration: Elli Griff	Napoleon	17	f	2024
89	Production Design: Ruth De Jong; Set Decoration: Claire Kaufman	Oppenheimer	17	f	2024
90	Production Design: James Price and Shona Heath; Set Decoration: Zsuzsa Mihalek	Poor Things	17	f	2024
91	Tal Kantor and Amit R. Gicelter	Letter To A Pig	18	f	2024
92	Jerusha Hess and Jared Hess	Ninety-Five Senses	18	f	2024
93	Yegane Moghaddam	Our Uniform	18	f	2024
94	Stéphanie Clément and Marc Rius	Pachyderme	18	f	2024
95	Dave Mullins and Brad Booker	War Is Over! Inspired By The Music Of John & Yoko	18	f	2024
96	Misan Harriman and Nicky Bentham	The After	19	f	2024
97	Vincent René-Lortie and Samuel Caron	Invincible	19	f	2024
98	Lasse Lyskjær Noer and Christian Norlyk	Knight Of Fortune	19	f	2024
99	Nazrin Choudhury and Sara McFarlane	Red, White And Blue	19	f	2024
100	Wes Anderson and Steven Rales	The Wonderful Story Of Henry Sugar	19	f	2024
101	Ian Voigt, Erik Aadahl, Ethan Van der Ryn, Tom Ozanich and Dean Zupancic	The Creator	20	f	2024
102	Steven A. Morrow, Richard King, Jason Ruder, Tom Ozanich and Dean Zupancic	Maestro	20	f	2024
103	Chris Munro, James H. Mather, Chris Burdon and Mark Taylor	Mission: Impossible - Dead Reckoning Part One	20	f	2024
104	Willie Burton, Richard King, Gary A. Rizzo and Kevin O'Connell	Oppenheimer	20	f	2024
105	Tarn Willers and Johnnie Burn	The Zone Of Interest	20	f	2024
106	Jay Cooper, Ian Comley, Andrew Roberts and Neil Corbould	The Creator	21	f	2024
107	Takashi Yamazaki, Kiyoko Shibuya, Masaki Takahashi and Tatsuji Nojima	Godzilla Minus One	21	f	2024
108	Stephane Ceretti, Alexis Wajsbrot, Guy Williams and Theo Bialek	Guardians Of The Galaxy Vol. 3	21	f	2024
109	Alex Wuttke, Simone Coco, Jeff Sutherland and Neil Corbould	Mission: Impossible - Dead Reckoning Part One	21	f	2024
110	Charley Henley, Luc-Ewen Martin-Fenouillet, Simone Coco and Neil Corbould	Napoleon	21	f	2024
111	Written for the screen by Cord Jefferson	American Fiction	22	f	2024
112	Written by Greta Gerwig & Noah Baumbach	Barbie	22	f	2024
113	Written for the screen by Christopher Nolan	Oppenheimer	22	f	2024
114	Screenplay by Tony McNamara	Poor Things	22	f	2024
115	Written by Jonathan Glazer	The Zone Of Interest	22	f	2024
116	Screenplay - Justine Triet and Arthur Harari	Anatomy Of A Fall	23	f	2024
117	Written by David Hemingson	The Holdovers	23	f	2024
118	Written by Bradley Cooper & Josh Singer	Maestro	23	f	2024
119	Screenplay by Samy Burch; Story by Samy Burch & Alex Mechanik	May December	23	f	2024
120	Written by Celine Song	Past Lives	23	f	2024
6	Bradley Cooper, Steven Spielberg, Fred Berner, Amy Durning and Kristie Macosko Krieger, Producers	Maestro	1	t	2024
\.


--
-- Data for Name: predictions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.predictions (id, user_id, nominee_id, category_id) FROM stdin;
7	2	11	2
8	2	16	3
73	5	53	10
74	5	70	13
75	6	36	7
76	6	52	10
79	6	59	11
80	6	68	13
2	1	20	3
85	7	52	10
86	7	66	13
89	9	55	10
90	9	69	13
3	1	27	5
1	1	3	2
27	1	2	4
93	1	4	8
109	8	51	10
110	8	113	22
117	17	36	7
111	17	54	10
116	17	68	13
43	1	38	7
4	1	47	9
45	1	52	10
46	1	62	12
5	1	69	13
54	1	76	15
6	1	84	16
56	1	118	23
120	18	36	7
121	18	51	10
122	18	66	13
131	18	85	16
123	18	116	23
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, username, room_id, admin, year) FROM stdin;
1	eric a	eric a	asdf	f	2024
2	eric b	eric b	asdf	f	2024
3	eric c	eric c	asdf	f	2024
5	eric9	eric9	asdf8	f	2024
6	eric d	eric d	asdf	f	2024
7	testeroo	magoo	testeroo	f	2024
8	wan	gan	testeroo	f	2024
9	testeroooo	magoo	test	f	2024
10	eric	ericydauenhauer	asdf	f	2024
16	sdfsdaf	sdfdsafsdf	asdf	f	2024
17	eric e	eric e	asdf	f	2024
18	eric f	eric f	asdf	f	2024
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 23, true);


--
-- Name: nominees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nominees_id_seq', 120, true);


--
-- Name: predictions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.predictions_id_seq', 132, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 18, true);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: nominees nominees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nominees
    ADD CONSTRAINT nominees_pkey PRIMARY KEY (id);


--
-- Name: predictions predictions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predictions
    ADD CONSTRAINT predictions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_unique_room_id_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_unique_room_id_name ON public.users USING btree (name, room_id) NULLS NOT DISTINCT;


--
-- Name: index_unique_room_id_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_unique_room_id_username ON public.users USING btree (username, room_id) NULLS NOT DISTINCT;


--
-- Name: index_unique_user_id_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_unique_user_id_category_id ON public.predictions USING btree (user_id, category_id) NULLS NOT DISTINCT;


--
-- Name: index_unique_winner_year_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_unique_winner_year_category_id ON public.nominees USING btree (winner, year, category_id) NULLS NOT DISTINCT WHERE (winner = true);


--
-- Name: nominees category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nominees
    ADD CONSTRAINT category_id FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: predictions category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predictions
    ADD CONSTRAINT category_id FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: predictions nominee_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predictions
    ADD CONSTRAINT nominee_id FOREIGN KEY (nominee_id) REFERENCES public.nominees(id) ON DELETE CASCADE;


--
-- Name: predictions user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predictions
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

