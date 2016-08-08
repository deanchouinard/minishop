--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: line_items; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE line_items (
    id integer NOT NULL,
    quantity integer,
    total_price numeric(15,2),
    product_id integer,
    order_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.line_items OWNER TO postgres;

--
-- Name: line_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE line_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.line_items_id_seq OWNER TO postgres;

--
-- Name: line_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE line_items_id_seq OWNED BY line_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE orders (
    id integer NOT NULL,
    name character varying(255),
    address text,
    email character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    pay_type_id integer
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: pay_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pay_types (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    description character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.pay_types OWNER TO postgres;

--
-- Name: pay_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pay_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pay_types_id_seq OWNER TO postgres;

--
-- Name: pay_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pay_types_id_seq OWNED BY pay_types.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE products (
    id integer NOT NULL,
    title character varying(255),
    description text,
    image_url character varying(255),
    price numeric(8,2) DEFAULT 0,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sessions (
    id integer NOT NULL,
    key character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cart_data bytea
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sessions_id_seq OWNED BY sessions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY line_items ALTER COLUMN id SET DEFAULT nextval('line_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pay_types ALTER COLUMN id SET DEFAULT nextval('pay_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sessions ALTER COLUMN id SET DEFAULT nextval('sessions_id_seq'::regclass);


--
-- Data for Name: line_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY line_items (id, quantity, total_price, product_id, order_id, inserted_at, updated_at) FROM stdin;
1	1	\N	1	13	2016-05-10 11:09:07	2016-05-10 11:09:07
2	1	\N	2	13	2016-05-10 11:09:08	2016-05-10 11:09:08
3	1	10.50	1	14	2016-05-10 11:13:56	2016-05-10 11:13:56
4	1	123.45	2	14	2016-05-10 11:13:56	2016-05-10 11:13:56
5	1	10.50	1	15	2016-05-10 11:49:37	2016-05-10 11:49:37
6	1	123.45	2	15	2016-05-10 11:49:37	2016-05-10 11:49:37
7	1	10.50	1	16	2016-05-10 11:51:14	2016-05-10 11:51:14
8	1	123.45	2	16	2016-05-10 11:51:14	2016-05-10 11:51:14
9	1	10.50	1	17	2016-05-10 11:52:58	2016-05-10 11:52:58
10	1	123.45	2	17	2016-05-10 11:52:58	2016-05-10 11:52:58
11	1	10.50	1	18	2016-05-10 11:56:31	2016-05-10 11:56:31
12	1	123.45	2	18	2016-05-10 11:56:31	2016-05-10 11:56:31
13	1	10.50	1	19	2016-05-11 01:50:29	2016-05-11 01:50:29
14	1	123.45	2	19	2016-05-11 01:50:29	2016-05-11 01:50:29
15	1	10.50	1	20	2016-05-11 10:42:15	2016-05-11 10:42:15
16	1	123.45	2	20	2016-05-11 10:42:15	2016-05-11 10:42:15
17	1	10.50	1	21	2016-05-11 10:45:59	2016-05-11 10:45:59
18	1	123.45	2	21	2016-05-11 10:45:59	2016-05-11 10:45:59
19	1	10.50	1	22	2016-05-11 11:11:15	2016-05-11 11:11:15
20	1	123.45	2	22	2016-05-11 11:11:15	2016-05-11 11:11:15
21	3	10.50	1	25	2016-06-18 11:54:40	2016-06-18 11:54:40
22	1	123.45	2	25	2016-06-18 11:54:40	2016-06-18 11:54:40
23	3	31.50	1	28	2016-06-18 12:09:45	2016-06-18 12:09:45
24	1	123.45	2	28	2016-06-18 12:09:45	2016-06-18 12:09:45
\.


--
-- Name: line_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('line_items_id_seq', 24, true);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY orders (id, name, address, email, inserted_at, updated_at, pay_type_id) FROM stdin;
1	Test	test	test@test	2016-05-10 02:39:23	2016-05-10 02:39:23	\N
2	Test	test	test@test	2016-05-10 02:40:46	2016-05-10 02:40:46	\N
3	two	two	two@two.com	2016-05-10 10:35:39	2016-05-10 10:35:39	\N
4	two	two	two@two.com	2016-05-10 10:36:27	2016-05-10 10:36:27	\N
5	two	two	two@two.com	2016-05-10 10:37:51	2016-05-10 10:37:51	\N
6	two	two	two@two.com	2016-05-10 10:39:39	2016-05-10 10:39:39	\N
7	two	two	two@two.com	2016-05-10 10:48:39	2016-05-10 10:48:39	\N
8	two	two	two@two.com	2016-05-10 10:49:58	2016-05-10 10:49:58	\N
9	two	two	two@two.com	2016-05-10 10:51:48	2016-05-10 10:51:48	\N
10	two	two	two@two.com	2016-05-10 11:03:43	2016-05-10 11:03:43	\N
11	two	two	two@two.com	2016-05-10 11:05:14	2016-05-10 11:05:14	\N
12	two	two	two@two.com	2016-05-10 11:05:50	2016-05-10 11:05:50	\N
13	two	two	two@two.com	2016-05-10 11:09:07	2016-05-10 11:09:07	\N
14	third	third	third@third.com	2016-05-10 11:13:56	2016-05-10 11:13:56	\N
15	four	foru	for@for.com	2016-05-10 11:49:37	2016-05-10 11:49:37	\N
16	four	foru	for@for.com	2016-05-10 11:51:14	2016-05-10 11:51:14	\N
17	four	foru	for@for.com	2016-05-10 11:52:58	2016-05-10 11:52:58	\N
18	four	foru	for@for.com	2016-05-10 11:56:31	2016-05-10 11:56:31	\N
19	four	foru	for@for.com	2016-05-11 01:50:28	2016-05-11 01:50:28	\N
20	five	five	five@fie	2016-05-11 10:42:15	2016-05-11 10:42:15	\N
21	five	five	five@fie	2016-05-11 10:45:59	2016-05-11 10:45:59	\N
22	five	five	five@fie	2016-05-11 11:11:15	2016-05-11 11:11:15	2
23	\N	\N	\N	2016-06-12 02:23:19	2016-06-12 02:23:19	\N
24	Test on	test one	test@test.com	2016-06-18 11:51:34	2016-06-18 11:51:34	2
25	Test on	test one	test@test.com	2016-06-18 11:54:40	2016-06-18 11:54:40	2
26	Test on	test one	test@test.com	2016-06-18 11:58:08	2016-06-18 11:58:08	2
27	Test on	test one	test@test.com	2016-06-18 12:01:32	2016-06-18 12:01:32	2
28	Test on	test one	test@test.com	2016-06-18 12:09:45	2016-06-18 12:09:45	2
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('orders_id_seq', 28, true);


--
-- Data for Name: pay_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pay_types (id, code, description, inserted_at, updated_at) FROM stdin;
1	cc	Credit card	2016-05-08 11:41:25	2016-05-08 11:41:25
2	check	Check	2016-05-08 11:44:35	2016-05-08 11:44:35
3	po	Purchase order	2016-05-08 11:44:35	2016-05-08 11:44:35
\.


--
-- Name: pay_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pay_types_id_seq', 3, true);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY products (id, title, description, image_url, price, inserted_at, updated_at) FROM stdin;
1	First Product	The first product	https://localhost/first_product.jpg	10.50	2016-04-21 12:08:10	2016-04-21 12:08:10
2	Second Product	The second product	https://localhost/first_product.jpg	123.45	2016-05-04 10:41:30	2016-05-04 10:41:30
\.


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('products_id_seq', 2, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version, inserted_at) FROM stdin;
20160421104053	2016-04-21 11:01:59
20160507022648	2016-05-07 10:46:11
20160507030538	2016-05-07 10:46:11
20160508022727	2016-05-08 02:33:54
20160508103521	2016-05-08 10:52:05
20160508112029	2016-05-08 11:29:24
20160603030055	2016-06-03 03:04:35
20160604104350	2016-06-04 10:51:49
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sessions (id, key, inserted_at, updated_at, cart_data) FROM stdin;
1	AAAA	2016-06-04 10:57:30	2016-06-04 10:57:30	\\x83740000000264000770726f645f696461046400037174796101
2	AAA	2016-06-04 15:14:07	2016-06-05 13:00:55	\\x83740000000364000a5f5f7374727563745f5f640011456c697869722e54636172742e436172746400076175746f5f696461056400056974656d737400000004610174000000036400026964610164000770726f645f696461046400037174796101610274000000036400026964610264000770726f645f696461056400037174796101610374000000036400026964610364000770726f645f696461066400037174796101610474000000036400026964610464000770726f645f696461076400037174796101
3	44359	2016-06-16 03:17:14	2016-06-18 11:45:22	\\x83740000000364000a5f5f7374727563745f5f640011456c697869722e54636172742e436172746400076175746f5f696461036400056974656d737400000002610174000000036400026964610164000a70726f647563745f696461016400037174796103610274000000036400026964610264000a70726f647563745f696461026400037174796101
13	72305	2016-06-20 02:07:24	2016-06-20 02:07:24	\\x83740000000364000a5f5f7374727563745f5f640011456c697869722e54636172742e436172746400076175746f5f696461026400056974656d737400000001610174000000036400026964610164000a70726f647563745f696461016400037174796101
14	94582	2016-06-20 02:09:08	2016-06-20 02:09:18	\\x83740000000364000a5f5f7374727563745f5f640011456c697869722e54636172742e436172746400076175746f5f696461036400056974656d737400000002610174000000036400026964610164000a70726f647563745f696461026400037174796102610274000000036400026964610264000a70726f647563745f696461016400037174796101
15	19858	2016-06-20 10:34:47	2016-06-20 10:34:47	\\x83740000000364000a5f5f7374727563745f5f640011456c697869722e54636172742e436172746400076175746f5f696461026400056974656d737400000001610174000000036400026964610164000a70726f647563745f696461016400037174796101
16	63956	2016-06-20 10:36:06	2016-06-20 10:36:06	\\x83740000000364000a5f5f7374727563745f5f640011456c697869722e54636172742e436172746400076175746f5f696461026400056974656d737400000001610174000000036400026964610164000a70726f647563745f696461026400037174796101
17	16220	2016-06-20 10:36:16	2016-06-20 10:36:16	\\x83740000000364000a5f5f7374727563745f5f640011456c697869722e54636172742e436172746400076175746f5f696461026400056974656d737400000001610174000000036400026964610164000a70726f647563745f696461026400037174796102
18	43437	2016-06-21 10:36:52	2016-06-21 10:36:52	\\x83740000000364000a5f5f7374727563745f5f640011456c697869722e54636172742e436172746400076175746f5f696461026400056974656d737400000001610174000000036400026964610164000a70726f647563745f696461016400037174796101
\.


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sessions_id_seq', 18, true);


--
-- Name: line_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY line_items
    ADD CONSTRAINT line_items_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: pay_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pay_types
    ADD CONSTRAINT pay_types_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: line_items_order_id_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX line_items_order_id_index ON line_items USING btree (order_id);


--
-- Name: line_items_product_id_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX line_items_product_id_index ON line_items USING btree (product_id);


--
-- Name: pay_types_code_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pay_types_code_index ON pay_types USING btree (code);


--
-- Name: sessions_key_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX sessions_key_index ON sessions USING btree (key);


--
-- Name: line_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY line_items
    ADD CONSTRAINT line_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES orders(id);


--
-- Name: line_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY line_items
    ADD CONSTRAINT line_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id);


--
-- Name: orders_pay_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pay_type_id_fkey FOREIGN KEY (pay_type_id) REFERENCES pay_types(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: dean
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM dean;
GRANT ALL ON SCHEMA public TO dean;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

