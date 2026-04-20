--
-- PostgreSQL database dump
--

\restrict Vk2OOfP5My9d5Yrr5uAsxdHaY5LomfYOpanFmfDm0yPtpCZKpq0gbgffjD3mGrp

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg13+1)
-- Dumped by pg_dump version 18.3 (Debian 18.3-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: categories; Type: TABLE; Schema: public; Owner: techstore_user
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.categories OWNER TO techstore_user;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: techstore_user
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO techstore_user;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: techstore_user
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: techstore_user
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer,
    product_id integer,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL
);


ALTER TABLE public.order_items OWNER TO techstore_user;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: techstore_user
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO techstore_user;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: techstore_user
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: techstore_user
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id integer,
    total_amount numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.orders OWNER TO techstore_user;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: techstore_user
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO techstore_user;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: techstore_user
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: techstore_user
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    price numeric(10,2) NOT NULL,
    category_id integer,
    stock integer NOT NULL,
    information text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.products OWNER TO techstore_user;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: techstore_user
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO techstore_user;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: techstore_user
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: techstore_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cupdated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO techstore_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: techstore_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO techstore_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: techstore_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: techstore_user
--

COPY public.categories (id, name) FROM stdin;
1	Notebooks
2	Smartphones
3	Headphones
4	Cameras
5	Gaming Consoles
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: techstore_user
--

COPY public.order_items (id, order_id, product_id, quantity, price) FROM stdin;
1	1	1	1	1299.99
2	1	4	1	699.00
3	1	8	1	249.99
4	2	10	2	4890.00
5	3	1	2	1299.99
6	3	4	2	699.00
7	4	8	1	249.99
8	5	10	3	4890.00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: techstore_user
--

COPY public.orders (id, user_id, total_amount, created_at, updated_at) FROM stdin;
1	1	2248.98	2026-04-15 18:05:45.886241	2026-04-15 18:05:45.886241
2	2	9780.00	2026-04-15 18:05:45.886241	2026-04-15 18:05:45.886241
3	3	3997.98	2026-04-15 18:05:45.886241	2026-04-15 18:05:45.886241
4	4	249.99	2026-04-15 18:05:45.886241	2026-04-15 18:05:45.886241
5	5	14670.00	2026-04-15 18:05:45.886241	2026-04-15 18:05:45.886241
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: techstore_user
--

COPY public.products (id, name, price, category_id, stock, information, created_at, updated_at) FROM stdin;
1	MacBook Pro 13"	1299.99	1	100	Apple M1 chip, 8GB RAM, 256GB SSD	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
2	MacBook Pro 16	1890.00	1	30	Apple M3 chip, 16GB RAM, 256GB SSD	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
3	MacBook Pro 16	2890.00	1	30	Apple M5 chip, 24GB RAM, 256GB SSD	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
4	iPhone 11	699.00	2	10	A13 Bionic chip, 4GB RAM, 64GB storage	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
5	iPhone 12	799.00	2	20	A15 Bionic chip, 4GB RAM, 64GB storage	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
6	iPhone 13	899.00	2	15	A18 Bionic chip, 4GB RAM, 64GB storage	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
7	Apple Max	2890.00	3	50	Apple MAX headphones	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
8	Sony WH-1000XM4	249.99	3	60	Noise-canceling wireless headphones	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
9	Bose QuietComfort 35 II	310.00	3	20	Wireless Bluetooth headphones with noise cancellation	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
10	Canon EOS R5	4890.00	4	10	45MP full-frame mirrorless camera	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
11	Nikon Z6 II	2000.00	4	28	24.5MP full-frame mirrorless camera	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
12	Nikon Z7 II	2800.00	4	22	35MP full-frame mirrorless camera	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
13	Xbox Series X	480.99	5	5	Powerful gaming console with fast load times	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
14	Switch 2	1480.99	5	5	Powerful gaming console	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
15	PlayStation 5	489.00	5	70	Next-gen gaming console with ultra-fast SSD	2026-04-15 18:05:40.370499	2026-04-15 18:05:40.370499
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: techstore_user
--

COPY public.users (id, name, email, created_at, cupdated_at) FROM stdin;
1	Sergey	sergey@example.com	2026-04-15 18:05:29.562675	2026-04-15 18:05:29.562675
2	Alex	alex@example.com	2026-04-15 18:05:29.562675	2026-04-15 18:05:29.562675
3	Pol	pol@example.com	2026-04-15 18:05:29.562675	2026-04-15 18:05:29.562675
4	Alina	alina@example.com	2026-04-15 18:05:29.562675	2026-04-15 18:05:29.562675
5	Jon	jon@example.com	2026-04-15 18:05:29.562675	2026-04-15 18:05:29.562675
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: techstore_user
--

SELECT pg_catalog.setval('public.categories_id_seq', 5, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: techstore_user
--

SELECT pg_catalog.setval('public.order_items_id_seq', 8, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: techstore_user
--

SELECT pg_catalog.setval('public.orders_id_seq', 5, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: techstore_user
--

SELECT pg_catalog.setval('public.products_id_seq', 15, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: techstore_user
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE RESTRICT;


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE RESTRICT;


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: techstore_user
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict Vk2OOfP5My9d5Yrr5uAsxdHaY5LomfYOpanFmfDm0yPtpCZKpq0gbgffjD3mGrp

