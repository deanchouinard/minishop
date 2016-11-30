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

-- 8/7/16;Dean - cause error with postgres user
-- CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
-- COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

----
create table users (
  id integer NOT NULL,
  name varchar(255),
  username varchar(255),
  email varchar(255),
  password_hash varchar(255),
  inserted_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
alter table public.users owner to postgres;

create sequence user_id_seq
  start with 1
  increment by 1
  no minvalue
  no maxvalue
  cache 1;

ALTER TABLE public.user_id_seq OWNER TO postgres;
ALTER SEQUENCE user_id_seq  OWNED BY users.id;
ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);

CREATE UNIQUE INDEX username_index ON users USING btree (username);

-- Addresses

create table addresses (
  id integer not null,
  address1 varchar(255),
  address2 varchar(255),
  city varchar(255),
  state char(2),
  zipcode char(11),
  phone char(11),
  user_id integer not null,
  inserted_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);

create sequence address_id_seq
  start with 1
  increment by 1
  no minvalue
  no maxvalue
  cache 1;

ALTER TABLE public.address_id_seq OWNER TO postgres;
ALTER SEQUENCE address_id_seq  OWNED BY addresses.id;
ALTER TABLE ONLY addresses ALTER COLUMN id SET DEFAULT nextval('address_id_seq'::regclass);

ALTER TABLE ONLY addresses
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);
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
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    pay_type_id integer,
    user_id integer,
    ship_address_id integer
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


CREATE INDEX orders_user_id_index ON orders USING btree (user_id);
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

-----
create table categories (
  id integer not null,
  name character varying(80),
  inserted_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);

create sequence categories_id_seq
  start with 1
  increment by 1
  no minvalue
  no maxvalue
  cache 1;

ALTER TABLE ONLY categories ALTER COLUMN id
  SET DEFAULT nextval('categories_id_seq'::regclass);

ALTER TABLE ONLY categories
  ADD CONSTRAINT categories_pkey PRIMARY KEY (id);

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE products (
    id integer NOT NULL,
    sku character varying(20),
    title character varying(255),
    description text,
    category_id integer,
    image_url character varying(255),
    price numeric(15,2) DEFAULT 0,
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


ALTER TABLE ONLY products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id)
    REFERENCES categories(id);
--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE carts (
    id integer NOT NULL,
    key character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cart_data bytea
);

ALTER TABLE public.carts OWNER TO postgres;

CREATE SEQUENCE carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.carts_id_seq OWNER TO postgres;

ALTER SEQUENCE carts_id_seq OWNED BY carts.id;


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

ALTER TABLE ONLY carts ALTER COLUMN id SET DEFAULT nextval('carts_id_seq'::regclass);


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

ALTER TABLE ONLY carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


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


CREATE UNIQUE INDEX carts_key_index ON carts USING btree (key);


--
-- Name: line_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY line_items
    ADD CONSTRAINT line_items_order_id_fkey FOREIGN KEY (order_id)
    REFERENCES orders(id);


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

alter table only orders
  add constraint orders_user_id_fkey foreign key (user_id) references users(id);

alter table only addresses
  add constraint addresses_user_id_fkey foreign key (user_id) references users(id);

alter table only orders
  add constraint orders_ship_address_id_fkey foreign key (ship_address_id)
  references addresses(id);

--
-- Name: public; Type: ACL; Schema: -; Owner: dean
--

-- 8/7/16 - dean; commented out 4 statements below because they cause error
-- when run with postgres user; not sure if need them
--
-- REVOKE ALL ON SCHEMA public FROM PUBLIC;
-- REVOKE ALL ON SCHEMA public FROM dean;
-- GRANT ALL ON SCHEMA public TO dean;
-- GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

