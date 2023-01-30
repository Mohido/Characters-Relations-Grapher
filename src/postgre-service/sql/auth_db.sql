--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2023-01-30 05:20:24 UTC

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

DROP DATABASE IF EXISTS auth_db;
--
-- TOC entry 4237 (class 1262 OID 16384)
-- Name: auth_db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE auth_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE auth_db OWNER TO postgres;

\connect auth_db

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
-- TOC entry 255 (class 1259 OID 17017)
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 17462)
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 17032)
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 17027)
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 17022)
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 17037)
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 17477)
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16398)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16756)
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 17726)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 17601)
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16766)
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 17266)
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 17280)
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 17767)
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 17285)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16409)
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 17055)
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16761)
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 16939)
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16414)
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 17136)
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 17522)
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 17517)
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16417)
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16420)
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16390)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16385)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 17783)
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16425)
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 17482)
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 17487)
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 17809)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 17496)
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 17505)
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 17508)
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 17514)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16802)
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 17579)
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 17204)
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 17201)
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16807)
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16816)
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 16920)
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 16925)
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 17198)
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16433)
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 16917)
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 17189)
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 17184)
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 17405)
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16791)
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16797)
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16439)
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16456)
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 17213)
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16909)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16464)
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 17919)
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16467)
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16474)
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16825)
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16484)
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 17148)
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 17141)
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 17848)
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 17432)
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 17417)
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 17355)
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 17824)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 17391)
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 17363)
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 17377)
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 17866)
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 17876)
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16487)
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 17447)
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16493)
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 16930)
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 17799)
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16498)
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16506)
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 17042)
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 17047)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16511)
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 17210)
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16516)
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16519)
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16522)
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 16828)
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16490)
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16533)
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- TOC entry 4181 (class 0 OID 17017)
-- Dependencies: 255
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4210 (class 0 OID 17462)
-- Dependencies: 284
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4184 (class 0 OID 17032)
-- Dependencies: 258
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('af7fbdef-bd40-474d-99af-77676f5ff450', NULL, 'auth-cookie', 'master', '2c69625b-688c-4ff3-984c-ee1ea9389133', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('70bfa37c-d5fb-40c8-8c56-2c354510957b', NULL, 'auth-spnego', 'master', '2c69625b-688c-4ff3-984c-ee1ea9389133', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('434ee3bf-a8e1-4bf7-a755-f0006650d33f', NULL, 'identity-provider-redirector', 'master', '2c69625b-688c-4ff3-984c-ee1ea9389133', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('dd8f82b5-5aba-493d-a86a-b843a1f661c6', NULL, NULL, 'master', '2c69625b-688c-4ff3-984c-ee1ea9389133', 2, 30, true, '6a71f76a-5fb1-4aa0-8c3c-a288130fefcd', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('18a7e25e-ee79-40aa-829f-ec64f2186ba0', NULL, 'auth-username-password-form', 'master', '6a71f76a-5fb1-4aa0-8c3c-a288130fefcd', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('92cba995-87aa-4843-99b7-2eaa210b93a7', NULL, NULL, 'master', '6a71f76a-5fb1-4aa0-8c3c-a288130fefcd', 1, 20, true, 'b69757c9-2f7c-493d-8cec-21a5fa558296', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('5e36c69c-1761-4495-af18-61b1a43846e3', NULL, 'conditional-user-configured', 'master', 'b69757c9-2f7c-493d-8cec-21a5fa558296', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('47d3bc94-8d1c-48f8-b3de-c1a06cc943f2', NULL, 'auth-otp-form', 'master', 'b69757c9-2f7c-493d-8cec-21a5fa558296', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('34e756e2-14b9-48a4-ad48-200bdd098211', NULL, 'direct-grant-validate-username', 'master', 'c216bfd3-be28-4da8-acb3-ffbb170d57c8', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('1bf6ff94-e375-477e-9735-9f4b83f0ef3c', NULL, 'direct-grant-validate-password', 'master', 'c216bfd3-be28-4da8-acb3-ffbb170d57c8', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('cb1dad47-acf6-4b95-9345-0ab9255f6050', NULL, NULL, 'master', 'c216bfd3-be28-4da8-acb3-ffbb170d57c8', 1, 30, true, '61c998d8-c1ce-44da-8e07-47e42f1ceaf2', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('04457ead-d491-4d91-9339-495fd1a753cb', NULL, 'conditional-user-configured', 'master', '61c998d8-c1ce-44da-8e07-47e42f1ceaf2', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('19053c66-1992-4946-ab25-204a390a85e4', NULL, 'direct-grant-validate-otp', 'master', '61c998d8-c1ce-44da-8e07-47e42f1ceaf2', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2c047ba6-869a-47c8-8990-70cb55b1498f', NULL, 'registration-page-form', 'master', '93dd0931-17e2-470c-a32a-2760e254ff5b', 0, 10, true, '6ab9cea2-bff7-4c74-b2b5-2c9213dc8fce', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2f808b38-f4eb-4328-a174-1a16b50acbdb', NULL, 'registration-user-creation', 'master', '6ab9cea2-bff7-4c74-b2b5-2c9213dc8fce', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('35a0d855-cea9-4275-b6a8-f1a26fe15e11', NULL, 'registration-profile-action', 'master', '6ab9cea2-bff7-4c74-b2b5-2c9213dc8fce', 0, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2dc856ca-43c1-4c9f-b481-8c7992209dad', NULL, 'registration-password-action', 'master', '6ab9cea2-bff7-4c74-b2b5-2c9213dc8fce', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('80761480-8eb7-4226-9731-7c0a72aab8a2', NULL, 'registration-recaptcha-action', 'master', '6ab9cea2-bff7-4c74-b2b5-2c9213dc8fce', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d79fa349-341c-47d2-8f6a-5f3426852cf7', NULL, 'reset-credentials-choose-user', 'master', '96466767-6a6b-4eb1-85df-a11a6a90c8d3', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e9fe7c47-4ab0-4856-8451-dc0499d986e4', NULL, 'reset-credential-email', 'master', '96466767-6a6b-4eb1-85df-a11a6a90c8d3', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('3bfe565d-a537-48be-9bbf-44f9a5b82989', NULL, 'reset-password', 'master', '96466767-6a6b-4eb1-85df-a11a6a90c8d3', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('deb01dcf-331a-4759-ad0b-d76c5a3a759e', NULL, NULL, 'master', '96466767-6a6b-4eb1-85df-a11a6a90c8d3', 1, 40, true, '2057b2a4-7566-406f-8c0d-85b8f2ef98df', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('8b8e37dd-b4e4-40a6-b43e-173ac3b377b1', NULL, 'conditional-user-configured', 'master', '2057b2a4-7566-406f-8c0d-85b8f2ef98df', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('dd7e6fbc-ab02-4403-8101-94841a543ba0', NULL, 'reset-otp', 'master', '2057b2a4-7566-406f-8c0d-85b8f2ef98df', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('74243169-9965-4740-8c90-4a3561710c4d', NULL, 'client-secret', 'master', '0b5b3be6-73db-4a1f-8b77-9667565cbf2c', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('08ec32fb-262e-4371-972d-b14b62cf86d0', NULL, 'client-jwt', 'master', '0b5b3be6-73db-4a1f-8b77-9667565cbf2c', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('a84ea71c-7245-443b-a1f8-50c0efbf2bd6', NULL, 'client-secret-jwt', 'master', '0b5b3be6-73db-4a1f-8b77-9667565cbf2c', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e46f3540-3511-44a5-97a4-f9b3e2849921', NULL, 'client-x509', 'master', '0b5b3be6-73db-4a1f-8b77-9667565cbf2c', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d0490ced-9120-43ed-9579-159fbb493080', NULL, 'idp-review-profile', 'master', '26c006ff-8b70-431c-874a-5c37a40d8a00', 0, 10, false, NULL, '8320e566-9d35-4e09-adf1-f68ff2806ac4');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('1c3b2154-6fbc-4c2f-b621-dea8cdcf9e5a', NULL, NULL, 'master', '26c006ff-8b70-431c-874a-5c37a40d8a00', 0, 20, true, '5e571ac7-63d8-4e80-b0db-89742bff4970', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('6c93a02d-da13-41bf-b95a-ee9378aa02b9', NULL, 'idp-create-user-if-unique', 'master', '5e571ac7-63d8-4e80-b0db-89742bff4970', 2, 10, false, NULL, '92a0515a-565b-4cae-9509-d6222d0ca1d3');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9b605f06-9ddd-45b1-958c-412b78cabf21', NULL, NULL, 'master', '5e571ac7-63d8-4e80-b0db-89742bff4970', 2, 20, true, '46f36384-8a41-4a50-b9cb-565e5f93176e', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('cfe2cf88-69d0-4599-87e6-dde4d0730e8d', NULL, 'idp-confirm-link', 'master', '46f36384-8a41-4a50-b9cb-565e5f93176e', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9fe2836e-80e3-436a-b9b2-a27509995dd6', NULL, NULL, 'master', '46f36384-8a41-4a50-b9cb-565e5f93176e', 0, 20, true, '6c1adb22-cc75-44ac-9902-8d967c612ef3', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('8a985a31-6250-4c3a-b3ba-450cc6ac3452', NULL, 'idp-email-verification', 'master', '6c1adb22-cc75-44ac-9902-8d967c612ef3', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e547276d-dfa7-4600-8f35-557affb96360', NULL, NULL, 'master', '6c1adb22-cc75-44ac-9902-8d967c612ef3', 2, 20, true, '30125d05-e43b-4298-9c01-b3884add8e24', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b0550d84-fcea-4ce6-8369-bea2f7215dcc', NULL, 'idp-username-password-form', 'master', '30125d05-e43b-4298-9c01-b3884add8e24', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('13eeefa8-56c5-4ee8-8ee4-a272a39a7242', NULL, NULL, 'master', '30125d05-e43b-4298-9c01-b3884add8e24', 1, 20, true, '52680866-923d-41d9-91f8-f518401270f2', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2fffa499-69b0-4983-b139-9ba9b56949e6', NULL, 'conditional-user-configured', 'master', '52680866-923d-41d9-91f8-f518401270f2', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2fa39d68-5657-4d90-95f7-1d6f369998b8', NULL, 'auth-otp-form', 'master', '52680866-923d-41d9-91f8-f518401270f2', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('5848a7e2-fabe-47e9-80da-a3b7ff10c2de', NULL, 'http-basic-authenticator', 'master', 'd4d61710-919c-461e-979c-7c2ecf9b98c6', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2cf00ede-efde-4ce4-92c5-449a2c63cd74', NULL, 'docker-http-basic-authenticator', 'master', '0a3944f5-8d81-4f6a-88c2-1f6d86faf5b6', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d8672cc9-bf1f-4348-bd1f-cf5ce266535b', NULL, 'no-cookie-redirect', 'master', 'd3e9c52c-c011-43f7-ab37-d05c2f04c6b6', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('52bc6348-080d-4eda-bbbe-099320a5379c', NULL, NULL, 'master', 'd3e9c52c-c011-43f7-ab37-d05c2f04c6b6', 0, 20, true, '54dc12b9-ecf6-4275-9533-32b2e813d11d', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('dbee6d9e-ce2b-4014-b26c-2a1778cfa6d2', NULL, 'basic-auth', 'master', '54dc12b9-ecf6-4275-9533-32b2e813d11d', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d5a564d8-ea12-46f3-a31b-0a397c0305f9', NULL, 'basic-auth-otp', 'master', '54dc12b9-ecf6-4275-9533-32b2e813d11d', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('60eeba36-bbd8-445c-bdf2-ee7cba919af1', NULL, 'auth-spnego', 'master', '54dc12b9-ecf6-4275-9533-32b2e813d11d', 3, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('788ebb75-6f3c-4b71-89a4-1123ea1d5623', NULL, 'auth-cookie', 'CRG', '56c176fb-14cc-4fc9-9909-7acc1b3a6639', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f5218ea7-4295-4a06-8d89-fdfdbe48111b', NULL, 'auth-spnego', 'CRG', '56c176fb-14cc-4fc9-9909-7acc1b3a6639', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('77518557-93b4-45b6-90bd-bb3d0a828ecc', NULL, 'identity-provider-redirector', 'CRG', '56c176fb-14cc-4fc9-9909-7acc1b3a6639', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f34ce08e-5883-4000-96de-dc05b05e35b5', NULL, NULL, 'CRG', '56c176fb-14cc-4fc9-9909-7acc1b3a6639', 2, 30, true, 'ffd9e9aa-88f7-4bd0-8ca4-c79c6d11efd1', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9953a43d-13b0-403d-abbc-98d1c06a8e4d', NULL, 'auth-username-password-form', 'CRG', 'ffd9e9aa-88f7-4bd0-8ca4-c79c6d11efd1', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('faa593a8-2d42-4713-b197-f8e497bc65be', NULL, NULL, 'CRG', 'ffd9e9aa-88f7-4bd0-8ca4-c79c6d11efd1', 1, 20, true, '9170e403-1656-4fe7-a6ca-2cbc35800950', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4953cdea-883e-427b-a70b-1b294e4a1570', NULL, 'conditional-user-configured', 'CRG', '9170e403-1656-4fe7-a6ca-2cbc35800950', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0295b2d4-2087-4260-bef3-b269ba5609cd', NULL, 'auth-otp-form', 'CRG', '9170e403-1656-4fe7-a6ca-2cbc35800950', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('da0c97fc-d028-4034-b82c-7c8544f79c14', NULL, 'direct-grant-validate-username', 'CRG', 'a1dd9f36-fe5b-4781-85d0-c0e5b8c8c911', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('3347a73b-34e8-4ff2-b2ab-53debbe3e3e4', NULL, 'direct-grant-validate-password', 'CRG', 'a1dd9f36-fe5b-4781-85d0-c0e5b8c8c911', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f0810a75-b6c5-467f-95e5-9916bab4d2e4', NULL, NULL, 'CRG', 'a1dd9f36-fe5b-4781-85d0-c0e5b8c8c911', 1, 30, true, '13e5943f-3fdb-4c6e-ad08-589aa688d014', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('311c00b0-8e19-49de-9f5e-181c9c66c034', NULL, 'conditional-user-configured', 'CRG', '13e5943f-3fdb-4c6e-ad08-589aa688d014', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('af027dc0-7840-490d-9841-4fbe1cf85d73', NULL, 'direct-grant-validate-otp', 'CRG', '13e5943f-3fdb-4c6e-ad08-589aa688d014', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0efe989c-4634-44de-af7f-e1eee507a8fa', NULL, 'registration-page-form', 'CRG', '9e0dcc8a-4f14-4716-b7c1-39cbe055491f', 0, 10, true, '98df4f6d-ee7a-4715-95d7-4bfa1c50afa0', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('8baf984d-ac91-4b7c-b7d2-87e1c4ed8a40', NULL, 'registration-user-creation', 'CRG', '98df4f6d-ee7a-4715-95d7-4bfa1c50afa0', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d74546e9-80d4-4312-a8d5-b92d5304874b', NULL, 'registration-profile-action', 'CRG', '98df4f6d-ee7a-4715-95d7-4bfa1c50afa0', 0, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e117c357-2846-486b-879c-cf6f23d56731', NULL, 'registration-password-action', 'CRG', '98df4f6d-ee7a-4715-95d7-4bfa1c50afa0', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('485a6c53-5a26-4143-a660-457b7da83880', NULL, 'registration-recaptcha-action', 'CRG', '98df4f6d-ee7a-4715-95d7-4bfa1c50afa0', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('8a0cf59d-614d-49d2-a017-bad89bbf0ba1', NULL, 'reset-credentials-choose-user', 'CRG', 'e7905d30-68c8-41e7-993b-51eccc8af482', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e6448d0e-bbdf-49b1-ae76-a89690d4678f', NULL, 'reset-credential-email', 'CRG', 'e7905d30-68c8-41e7-993b-51eccc8af482', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('14d71eec-0c03-4d73-a456-870ee0f62faf', NULL, 'reset-password', 'CRG', 'e7905d30-68c8-41e7-993b-51eccc8af482', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('049944fc-8ee4-4dcc-9852-d26cb27c4807', NULL, NULL, 'CRG', 'e7905d30-68c8-41e7-993b-51eccc8af482', 1, 40, true, '2ab47dbc-97cb-4343-9020-4dfdf8dc2dd9', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('bc20a816-f569-4a23-ab02-a673f7dbf4a9', NULL, 'conditional-user-configured', 'CRG', '2ab47dbc-97cb-4343-9020-4dfdf8dc2dd9', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('dac24ada-0e0f-4bb4-832c-21cbb846a530', NULL, 'reset-otp', 'CRG', '2ab47dbc-97cb-4343-9020-4dfdf8dc2dd9', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('484fbc19-0f69-470b-b786-a5d94c345022', NULL, 'client-secret', 'CRG', '6761d32e-b13d-4f88-b71d-b3477e3a8587', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('6fd16b9d-b400-48d3-8944-8ec4f7739e61', NULL, 'client-jwt', 'CRG', '6761d32e-b13d-4f88-b71d-b3477e3a8587', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4be20477-e217-4280-bfa1-e338619e9bf3', NULL, 'client-secret-jwt', 'CRG', '6761d32e-b13d-4f88-b71d-b3477e3a8587', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('484da1e4-27cc-4e48-b175-cfffc63cfc9e', NULL, 'client-x509', 'CRG', '6761d32e-b13d-4f88-b71d-b3477e3a8587', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('081ed4a0-6b05-42b9-89f4-56fb0fd25fbb', NULL, 'idp-review-profile', 'CRG', 'ec72f1fc-6785-4be6-9709-79f9aedc8d4a', 0, 10, false, NULL, '5473dda5-1bb3-41af-b1d0-6b4fbc62d111');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('817f4abc-3edd-48a8-8686-f212ae83d050', NULL, NULL, 'CRG', 'ec72f1fc-6785-4be6-9709-79f9aedc8d4a', 0, 20, true, '750cb99e-9a59-4dad-ab09-6c38af1c4ad8', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('27be764b-6a45-4986-90a8-84e3da4a5f68', NULL, 'idp-create-user-if-unique', 'CRG', '750cb99e-9a59-4dad-ab09-6c38af1c4ad8', 2, 10, false, NULL, '0f00d8f9-b525-4df1-b10d-3f0789bdb0de');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('01b4a88b-cd43-40a1-bb12-ace0b7831663', NULL, NULL, 'CRG', '750cb99e-9a59-4dad-ab09-6c38af1c4ad8', 2, 20, true, '78dfec57-d879-44f9-8588-65362b975489', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('eb8b85f2-fee5-4b38-b6f7-af5d747b7209', NULL, 'idp-confirm-link', 'CRG', '78dfec57-d879-44f9-8588-65362b975489', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('098f0a6e-ba36-4f42-ba43-93f577d3e97c', NULL, NULL, 'CRG', '78dfec57-d879-44f9-8588-65362b975489', 0, 20, true, '0247f6e7-7342-4058-85f1-97b4fec1755b', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('baafc904-6b1d-4564-8e5d-3d8953127fec', NULL, 'idp-email-verification', 'CRG', '0247f6e7-7342-4058-85f1-97b4fec1755b', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('911d1564-3b88-483b-bea3-252df721e0c6', NULL, NULL, 'CRG', '0247f6e7-7342-4058-85f1-97b4fec1755b', 2, 20, true, '8a267a50-e323-4046-a78d-aca5c83a639b', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('30bb27d9-6262-46bb-bd1b-7d0f3e39ecce', NULL, 'idp-username-password-form', 'CRG', '8a267a50-e323-4046-a78d-aca5c83a639b', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('486bae43-501d-4ae0-94d6-7abc4c1b0733', NULL, NULL, 'CRG', '8a267a50-e323-4046-a78d-aca5c83a639b', 1, 20, true, '9a5bc442-0b59-4502-81c0-0e6c273a7298', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('697a9528-cc72-4284-94e6-273e8741cc31', NULL, 'conditional-user-configured', 'CRG', '9a5bc442-0b59-4502-81c0-0e6c273a7298', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4fecf040-a3be-45fe-bb7c-8600d2841f4a', NULL, 'auth-otp-form', 'CRG', '9a5bc442-0b59-4502-81c0-0e6c273a7298', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('aef06fa6-aa5a-438b-a780-68e303de35b5', NULL, 'http-basic-authenticator', 'CRG', '25ab6e33-1604-48d7-8f37-a68fe315e458', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('95e16743-8723-455e-a3d6-b93f742fd58f', NULL, 'docker-http-basic-authenticator', 'CRG', '03ad5c2f-f75a-4fb4-b665-3acb5abd0ec7', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('36ea917c-7e10-4e43-b44f-be4bbcee8c66', NULL, 'no-cookie-redirect', 'CRG', 'c83060ed-fd2d-46fb-8c6b-ce966e05a1c8', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9dff651b-84ed-49dd-9633-4d901a29a3e7', NULL, NULL, 'CRG', 'c83060ed-fd2d-46fb-8c6b-ce966e05a1c8', 0, 20, true, '03268823-0aa8-4dc0-8784-860b3a4bb475', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d99ea1cd-1392-4671-8a3b-002cbb1c2468', NULL, 'basic-auth', 'CRG', '03268823-0aa8-4dc0-8784-860b3a4bb475', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('bca53c13-cdc0-4520-8736-da158a89ce04', NULL, 'basic-auth-otp', 'CRG', '03268823-0aa8-4dc0-8784-860b3a4bb475', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('406c93fc-8a25-494d-8ef4-32eab82b57ef', NULL, 'auth-spnego', 'CRG', '03268823-0aa8-4dc0-8784-860b3a4bb475', 3, 30, false, NULL, NULL);


--
-- TOC entry 4183 (class 0 OID 17027)
-- Dependencies: 257
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('2c69625b-688c-4ff3-984c-ee1ea9389133', 'browser', 'browser based authentication', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('6a71f76a-5fb1-4aa0-8c3c-a288130fefcd', 'forms', 'Username, password, otp and other auth forms.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('b69757c9-2f7c-493d-8cec-21a5fa558296', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('c216bfd3-be28-4da8-acb3-ffbb170d57c8', 'direct grant', 'OpenID Connect Resource Owner Grant', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('61c998d8-c1ce-44da-8e07-47e42f1ceaf2', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('93dd0931-17e2-470c-a32a-2760e254ff5b', 'registration', 'registration flow', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('6ab9cea2-bff7-4c74-b2b5-2c9213dc8fce', 'registration form', 'registration form', 'master', 'form-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('96466767-6a6b-4eb1-85df-a11a6a90c8d3', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('2057b2a4-7566-406f-8c0d-85b8f2ef98df', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('0b5b3be6-73db-4a1f-8b77-9667565cbf2c', 'clients', 'Base authentication for clients', 'master', 'client-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('26c006ff-8b70-431c-874a-5c37a40d8a00', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('5e571ac7-63d8-4e80-b0db-89742bff4970', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('46f36384-8a41-4a50-b9cb-565e5f93176e', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('6c1adb22-cc75-44ac-9902-8d967c612ef3', 'Account verification options', 'Method with which to verity the existing account', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('30125d05-e43b-4298-9c01-b3884add8e24', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('52680866-923d-41d9-91f8-f518401270f2', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('d4d61710-919c-461e-979c-7c2ecf9b98c6', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('0a3944f5-8d81-4f6a-88c2-1f6d86faf5b6', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('d3e9c52c-c011-43f7-ab37-d05c2f04c6b6', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('54dc12b9-ecf6-4275-9533-32b2e813d11d', 'Authentication Options', 'Authentication options.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('56c176fb-14cc-4fc9-9909-7acc1b3a6639', 'browser', 'browser based authentication', 'CRG', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('ffd9e9aa-88f7-4bd0-8ca4-c79c6d11efd1', 'forms', 'Username, password, otp and other auth forms.', 'CRG', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('9170e403-1656-4fe7-a6ca-2cbc35800950', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'CRG', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('a1dd9f36-fe5b-4781-85d0-c0e5b8c8c911', 'direct grant', 'OpenID Connect Resource Owner Grant', 'CRG', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('13e5943f-3fdb-4c6e-ad08-589aa688d014', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'CRG', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('9e0dcc8a-4f14-4716-b7c1-39cbe055491f', 'registration', 'registration flow', 'CRG', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('98df4f6d-ee7a-4715-95d7-4bfa1c50afa0', 'registration form', 'registration form', 'CRG', 'form-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('e7905d30-68c8-41e7-993b-51eccc8af482', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'CRG', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('2ab47dbc-97cb-4343-9020-4dfdf8dc2dd9', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'CRG', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('6761d32e-b13d-4f88-b71d-b3477e3a8587', 'clients', 'Base authentication for clients', 'CRG', 'client-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('ec72f1fc-6785-4be6-9709-79f9aedc8d4a', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'CRG', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('750cb99e-9a59-4dad-ab09-6c38af1c4ad8', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'CRG', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('78dfec57-d879-44f9-8588-65362b975489', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'CRG', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('0247f6e7-7342-4058-85f1-97b4fec1755b', 'Account verification options', 'Method with which to verity the existing account', 'CRG', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('8a267a50-e323-4046-a78d-aca5c83a639b', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'CRG', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('9a5bc442-0b59-4502-81c0-0e6c273a7298', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'CRG', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('25ab6e33-1604-48d7-8f37-a68fe315e458', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'CRG', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('03ad5c2f-f75a-4fb4-b665-3acb5abd0ec7', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'CRG', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('c83060ed-fd2d-46fb-8c6b-ce966e05a1c8', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'CRG', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('03268823-0aa8-4dc0-8784-860b3a4bb475', 'Authentication Options', 'Authentication options.', 'CRG', 'basic-flow', false, true);


--
-- TOC entry 4182 (class 0 OID 17022)
-- Dependencies: 256
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('8320e566-9d35-4e09-adf1-f68ff2806ac4', 'review profile config', 'master');
INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('92a0515a-565b-4cae-9509-d6222d0ca1d3', 'create unique user config', 'master');
INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('5473dda5-1bb3-41af-b1d0-6b4fbc62d111', 'review profile config', 'CRG');
INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('0f00d8f9-b525-4df1-b10d-3f0789bdb0de', 'create unique user config', 'CRG');


--
-- TOC entry 4185 (class 0 OID 17037)
-- Dependencies: 259
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('8320e566-9d35-4e09-adf1-f68ff2806ac4', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('92a0515a-565b-4cae-9509-d6222d0ca1d3', 'false', 'require.password.update.after.registration');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('5473dda5-1bb3-41af-b1d0-6b4fbc62d111', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('0f00d8f9-b525-4df1-b10d-3f0789bdb0de', 'false', 'require.password.update.after.registration');


--
-- TOC entry 4211 (class 0 OID 17477)
-- Dependencies: 285
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4142 (class 0 OID 16398)
-- Dependencies: 216
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('59533569-54f7-4686-b7ba-7346241d1be6', true, false, 'master-realm', 0, false, NULL, NULL, true, NULL, false, 'master', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('7d0e8031-37aa-4cf7-ab11-3eb40df011af', true, false, 'account', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('2875f6df-1a0e-463b-a362-593f26e8fa79', true, false, 'account-console', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('38a33770-f0a0-4b63-ace9-715ae4e4caaf', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('abac7ebf-4c69-4275-bb77-760a19933344', true, false, 'security-admin-console', 0, true, NULL, '/admin/master/console/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('00b9e57b-6580-4a75-8782-4fa5ef3f54fa', true, false, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('88464ba2-f74b-407a-ac8a-38d83e763db8', true, false, 'CRG-realm', 0, false, NULL, NULL, true, NULL, false, 'master', NULL, 0, false, false, 'CRG Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, false, 'realm-management', 0, false, NULL, NULL, true, NULL, false, 'CRG', 'openid-connect', 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('f6b41486-3352-4580-af22-418607631beb', true, false, 'account', 0, true, NULL, '/realms/CRG/account/', false, NULL, false, 'CRG', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('596d2e5a-b4eb-4b95-b725-dc582921b997', true, false, 'account-console', 0, true, NULL, '/realms/CRG/account/', false, NULL, false, 'CRG', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('7741f182-daa1-40f4-a3d0-c4b1706b5884', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, 'CRG', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('7a249ae3-dfb6-460a-b488-f44ef5d37554', true, false, 'security-admin-console', 0, true, NULL, '/admin/CRG/console/', false, NULL, false, 'CRG', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('a9058afe-1ac2-4295-a454-57ddc9e8c935', true, false, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, 'CRG', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', true, false, 'crg-app', 0, false, 'DDrgd1mAZNBeLwdHwLGtm8VWZr8iD8kJ', NULL, false, NULL, false, 'CRG', 'openid-connect', -1, false, false, 'Character Relations Graph', true, 'client-secret', NULL, 'An application describing the character relations graph', '986f732c-ff11-4d7a-878c-7b9a35446422', false, false, true, false);


--
-- TOC entry 4165 (class 0 OID 16756)
-- Dependencies: 239
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_attributes (client_id, value, name) VALUES ('2875f6df-1a0e-463b-a362-593f26e8fa79', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('abac7ebf-4c69-4275-bb77-760a19933344', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('596d2e5a-b4eb-4b95-b725-dc582921b997', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('7a249ae3-dfb6-460a-b488-f44ef5d37554', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'true', 'backchannel.logout.session.required');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'backchannel.logout.revoke.offline.tokens');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'saml.artifact.binding');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'saml.server.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'saml.assertion.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'saml.client.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'saml.encrypt');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'saml.authnstatement');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'saml.onetimeuse.condition');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'saml_force_name_id_format');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'saml.multivalued.roles');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'saml.force.post.binding');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'exclude.session.state.from.auth.response');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'oauth2.device.authorization.grant.enabled');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'oidc.ciba.grant.enabled');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'true', 'use.refresh.tokens');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'id.token.as.detached.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'tls.client.certificate.bound.access.tokens');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'require.pushed.authorization.requests');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'client_credentials.use_refresh_token');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'false', 'display.on.consent.screen');


--
-- TOC entry 4222 (class 0 OID 17726)
-- Dependencies: 296
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4221 (class 0 OID 17601)
-- Dependencies: 295
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4167 (class 0 OID 16766)
-- Dependencies: 241
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4199 (class 0 OID 17266)
-- Dependencies: 273
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('f94d82e0-6443-4b99-9aba-a59d70b06323', 'offline_access', 'master', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('28bdfcf3-7bff-4d63-8aa6-f442ea2c5f84', 'role_list', 'master', 'SAML role list', 'saml');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('60c834b4-8046-4f6c-8dbb-b0ef6430bc94', 'profile', 'master', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('7b4c52f1-bd0e-40ec-a332-50c0adcd2397', 'email', 'master', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('af432425-20ca-4f21-8a70-23e7c92b0fa8', 'address', 'master', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('9f6ecb03-57d0-4f8f-a350-ff5d15de02bc', 'phone', 'master', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('d7625354-2a00-4094-88d0-2a006811bcf1', 'roles', 'master', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('99c5f2b8-af85-416d-a519-7c5f39ba32b9', 'web-origins', 'master', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('298223df-31a6-4919-bc10-cc95f1559dce', 'microprofile-jwt', 'master', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('9cb30c0b-befb-4fe9-b066-641ec06b7880', 'offline_access', 'CRG', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('48196b94-8301-499d-8a73-03f39d54d2c0', 'role_list', 'CRG', 'SAML role list', 'saml');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('57f20769-ab20-46af-80e7-101f491f9813', 'profile', 'CRG', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('da6c7dc4-a51d-4826-bf03-88a91eaf2a3d', 'email', 'CRG', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('0ceb7c67-ee89-4ab0-9189-becbbb36acc7', 'address', 'CRG', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('e7527488-ca33-4530-a690-86da328fa389', 'phone', 'CRG', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('eb72d3a6-b376-4389-9469-c3eacc0500f6', 'roles', 'CRG', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('446066a7-1a98-4e6f-af46-75b13c6982d4', 'web-origins', 'CRG', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('9b8b4f1f-3b91-49d4-aa1f-d3694a55f08c', 'microprofile-jwt', 'CRG', 'Microprofile - JWT built-in scope', 'openid-connect');


--
-- TOC entry 4200 (class 0 OID 17280)
-- Dependencies: 274
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('f94d82e0-6443-4b99-9aba-a59d70b06323', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('f94d82e0-6443-4b99-9aba-a59d70b06323', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('28bdfcf3-7bff-4d63-8aa6-f442ea2c5f84', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('28bdfcf3-7bff-4d63-8aa6-f442ea2c5f84', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('60c834b4-8046-4f6c-8dbb-b0ef6430bc94', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('60c834b4-8046-4f6c-8dbb-b0ef6430bc94', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('60c834b4-8046-4f6c-8dbb-b0ef6430bc94', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('7b4c52f1-bd0e-40ec-a332-50c0adcd2397', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('7b4c52f1-bd0e-40ec-a332-50c0adcd2397', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('7b4c52f1-bd0e-40ec-a332-50c0adcd2397', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('af432425-20ca-4f21-8a70-23e7c92b0fa8', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('af432425-20ca-4f21-8a70-23e7c92b0fa8', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('af432425-20ca-4f21-8a70-23e7c92b0fa8', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('9f6ecb03-57d0-4f8f-a350-ff5d15de02bc', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('9f6ecb03-57d0-4f8f-a350-ff5d15de02bc', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('9f6ecb03-57d0-4f8f-a350-ff5d15de02bc', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('d7625354-2a00-4094-88d0-2a006811bcf1', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('d7625354-2a00-4094-88d0-2a006811bcf1', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('d7625354-2a00-4094-88d0-2a006811bcf1', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('99c5f2b8-af85-416d-a519-7c5f39ba32b9', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('99c5f2b8-af85-416d-a519-7c5f39ba32b9', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('99c5f2b8-af85-416d-a519-7c5f39ba32b9', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('298223df-31a6-4919-bc10-cc95f1559dce', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('298223df-31a6-4919-bc10-cc95f1559dce', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('9cb30c0b-befb-4fe9-b066-641ec06b7880', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('9cb30c0b-befb-4fe9-b066-641ec06b7880', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('48196b94-8301-499d-8a73-03f39d54d2c0', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('48196b94-8301-499d-8a73-03f39d54d2c0', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('57f20769-ab20-46af-80e7-101f491f9813', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('57f20769-ab20-46af-80e7-101f491f9813', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('57f20769-ab20-46af-80e7-101f491f9813', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('da6c7dc4-a51d-4826-bf03-88a91eaf2a3d', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('da6c7dc4-a51d-4826-bf03-88a91eaf2a3d', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('da6c7dc4-a51d-4826-bf03-88a91eaf2a3d', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('0ceb7c67-ee89-4ab0-9189-becbbb36acc7', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('0ceb7c67-ee89-4ab0-9189-becbbb36acc7', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('0ceb7c67-ee89-4ab0-9189-becbbb36acc7', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('e7527488-ca33-4530-a690-86da328fa389', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('e7527488-ca33-4530-a690-86da328fa389', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('e7527488-ca33-4530-a690-86da328fa389', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('eb72d3a6-b376-4389-9469-c3eacc0500f6', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('eb72d3a6-b376-4389-9469-c3eacc0500f6', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('eb72d3a6-b376-4389-9469-c3eacc0500f6', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('446066a7-1a98-4e6f-af46-75b13c6982d4', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('446066a7-1a98-4e6f-af46-75b13c6982d4', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('446066a7-1a98-4e6f-af46-75b13c6982d4', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('9b8b4f1f-3b91-49d4-aa1f-d3694a55f08c', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('9b8b4f1f-3b91-49d4-aa1f-d3694a55f08c', 'true', 'include.in.token.scope');


--
-- TOC entry 4223 (class 0 OID 17767)
-- Dependencies: 297
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7d0e8031-37aa-4cf7-ab11-3eb40df011af', '7b4c52f1-bd0e-40ec-a332-50c0adcd2397', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7d0e8031-37aa-4cf7-ab11-3eb40df011af', 'd7625354-2a00-4094-88d0-2a006811bcf1', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7d0e8031-37aa-4cf7-ab11-3eb40df011af', '60c834b4-8046-4f6c-8dbb-b0ef6430bc94', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7d0e8031-37aa-4cf7-ab11-3eb40df011af', '99c5f2b8-af85-416d-a519-7c5f39ba32b9', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7d0e8031-37aa-4cf7-ab11-3eb40df011af', 'af432425-20ca-4f21-8a70-23e7c92b0fa8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7d0e8031-37aa-4cf7-ab11-3eb40df011af', '9f6ecb03-57d0-4f8f-a350-ff5d15de02bc', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7d0e8031-37aa-4cf7-ab11-3eb40df011af', '298223df-31a6-4919-bc10-cc95f1559dce', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7d0e8031-37aa-4cf7-ab11-3eb40df011af', 'f94d82e0-6443-4b99-9aba-a59d70b06323', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('2875f6df-1a0e-463b-a362-593f26e8fa79', '7b4c52f1-bd0e-40ec-a332-50c0adcd2397', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('2875f6df-1a0e-463b-a362-593f26e8fa79', 'd7625354-2a00-4094-88d0-2a006811bcf1', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('2875f6df-1a0e-463b-a362-593f26e8fa79', '60c834b4-8046-4f6c-8dbb-b0ef6430bc94', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('2875f6df-1a0e-463b-a362-593f26e8fa79', '99c5f2b8-af85-416d-a519-7c5f39ba32b9', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('2875f6df-1a0e-463b-a362-593f26e8fa79', 'af432425-20ca-4f21-8a70-23e7c92b0fa8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('2875f6df-1a0e-463b-a362-593f26e8fa79', '9f6ecb03-57d0-4f8f-a350-ff5d15de02bc', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('2875f6df-1a0e-463b-a362-593f26e8fa79', '298223df-31a6-4919-bc10-cc95f1559dce', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('2875f6df-1a0e-463b-a362-593f26e8fa79', 'f94d82e0-6443-4b99-9aba-a59d70b06323', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('00b9e57b-6580-4a75-8782-4fa5ef3f54fa', '7b4c52f1-bd0e-40ec-a332-50c0adcd2397', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('00b9e57b-6580-4a75-8782-4fa5ef3f54fa', 'd7625354-2a00-4094-88d0-2a006811bcf1', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('00b9e57b-6580-4a75-8782-4fa5ef3f54fa', '60c834b4-8046-4f6c-8dbb-b0ef6430bc94', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('00b9e57b-6580-4a75-8782-4fa5ef3f54fa', '99c5f2b8-af85-416d-a519-7c5f39ba32b9', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('00b9e57b-6580-4a75-8782-4fa5ef3f54fa', 'af432425-20ca-4f21-8a70-23e7c92b0fa8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('00b9e57b-6580-4a75-8782-4fa5ef3f54fa', '9f6ecb03-57d0-4f8f-a350-ff5d15de02bc', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('00b9e57b-6580-4a75-8782-4fa5ef3f54fa', '298223df-31a6-4919-bc10-cc95f1559dce', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('00b9e57b-6580-4a75-8782-4fa5ef3f54fa', 'f94d82e0-6443-4b99-9aba-a59d70b06323', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('38a33770-f0a0-4b63-ace9-715ae4e4caaf', '7b4c52f1-bd0e-40ec-a332-50c0adcd2397', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('38a33770-f0a0-4b63-ace9-715ae4e4caaf', 'd7625354-2a00-4094-88d0-2a006811bcf1', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('38a33770-f0a0-4b63-ace9-715ae4e4caaf', '60c834b4-8046-4f6c-8dbb-b0ef6430bc94', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('38a33770-f0a0-4b63-ace9-715ae4e4caaf', '99c5f2b8-af85-416d-a519-7c5f39ba32b9', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('38a33770-f0a0-4b63-ace9-715ae4e4caaf', 'af432425-20ca-4f21-8a70-23e7c92b0fa8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('38a33770-f0a0-4b63-ace9-715ae4e4caaf', '9f6ecb03-57d0-4f8f-a350-ff5d15de02bc', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('38a33770-f0a0-4b63-ace9-715ae4e4caaf', '298223df-31a6-4919-bc10-cc95f1559dce', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('38a33770-f0a0-4b63-ace9-715ae4e4caaf', 'f94d82e0-6443-4b99-9aba-a59d70b06323', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('59533569-54f7-4686-b7ba-7346241d1be6', '7b4c52f1-bd0e-40ec-a332-50c0adcd2397', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('59533569-54f7-4686-b7ba-7346241d1be6', 'd7625354-2a00-4094-88d0-2a006811bcf1', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('59533569-54f7-4686-b7ba-7346241d1be6', '60c834b4-8046-4f6c-8dbb-b0ef6430bc94', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('59533569-54f7-4686-b7ba-7346241d1be6', '99c5f2b8-af85-416d-a519-7c5f39ba32b9', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('59533569-54f7-4686-b7ba-7346241d1be6', 'af432425-20ca-4f21-8a70-23e7c92b0fa8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('59533569-54f7-4686-b7ba-7346241d1be6', '9f6ecb03-57d0-4f8f-a350-ff5d15de02bc', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('59533569-54f7-4686-b7ba-7346241d1be6', '298223df-31a6-4919-bc10-cc95f1559dce', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('59533569-54f7-4686-b7ba-7346241d1be6', 'f94d82e0-6443-4b99-9aba-a59d70b06323', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('abac7ebf-4c69-4275-bb77-760a19933344', '7b4c52f1-bd0e-40ec-a332-50c0adcd2397', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('abac7ebf-4c69-4275-bb77-760a19933344', 'd7625354-2a00-4094-88d0-2a006811bcf1', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('abac7ebf-4c69-4275-bb77-760a19933344', '60c834b4-8046-4f6c-8dbb-b0ef6430bc94', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('abac7ebf-4c69-4275-bb77-760a19933344', '99c5f2b8-af85-416d-a519-7c5f39ba32b9', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('abac7ebf-4c69-4275-bb77-760a19933344', 'af432425-20ca-4f21-8a70-23e7c92b0fa8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('abac7ebf-4c69-4275-bb77-760a19933344', '9f6ecb03-57d0-4f8f-a350-ff5d15de02bc', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('abac7ebf-4c69-4275-bb77-760a19933344', '298223df-31a6-4919-bc10-cc95f1559dce', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('abac7ebf-4c69-4275-bb77-760a19933344', 'f94d82e0-6443-4b99-9aba-a59d70b06323', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f6b41486-3352-4580-af22-418607631beb', '57f20769-ab20-46af-80e7-101f491f9813', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f6b41486-3352-4580-af22-418607631beb', 'da6c7dc4-a51d-4826-bf03-88a91eaf2a3d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f6b41486-3352-4580-af22-418607631beb', '446066a7-1a98-4e6f-af46-75b13c6982d4', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f6b41486-3352-4580-af22-418607631beb', 'eb72d3a6-b376-4389-9469-c3eacc0500f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f6b41486-3352-4580-af22-418607631beb', 'e7527488-ca33-4530-a690-86da328fa389', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f6b41486-3352-4580-af22-418607631beb', '9cb30c0b-befb-4fe9-b066-641ec06b7880', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f6b41486-3352-4580-af22-418607631beb', '9b8b4f1f-3b91-49d4-aa1f-d3694a55f08c', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f6b41486-3352-4580-af22-418607631beb', '0ceb7c67-ee89-4ab0-9189-becbbb36acc7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('596d2e5a-b4eb-4b95-b725-dc582921b997', '57f20769-ab20-46af-80e7-101f491f9813', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('596d2e5a-b4eb-4b95-b725-dc582921b997', 'da6c7dc4-a51d-4826-bf03-88a91eaf2a3d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('596d2e5a-b4eb-4b95-b725-dc582921b997', '446066a7-1a98-4e6f-af46-75b13c6982d4', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('596d2e5a-b4eb-4b95-b725-dc582921b997', 'eb72d3a6-b376-4389-9469-c3eacc0500f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('596d2e5a-b4eb-4b95-b725-dc582921b997', 'e7527488-ca33-4530-a690-86da328fa389', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('596d2e5a-b4eb-4b95-b725-dc582921b997', '9cb30c0b-befb-4fe9-b066-641ec06b7880', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('596d2e5a-b4eb-4b95-b725-dc582921b997', '9b8b4f1f-3b91-49d4-aa1f-d3694a55f08c', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('596d2e5a-b4eb-4b95-b725-dc582921b997', '0ceb7c67-ee89-4ab0-9189-becbbb36acc7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a9058afe-1ac2-4295-a454-57ddc9e8c935', '57f20769-ab20-46af-80e7-101f491f9813', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a9058afe-1ac2-4295-a454-57ddc9e8c935', 'da6c7dc4-a51d-4826-bf03-88a91eaf2a3d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a9058afe-1ac2-4295-a454-57ddc9e8c935', '446066a7-1a98-4e6f-af46-75b13c6982d4', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a9058afe-1ac2-4295-a454-57ddc9e8c935', 'eb72d3a6-b376-4389-9469-c3eacc0500f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a9058afe-1ac2-4295-a454-57ddc9e8c935', 'e7527488-ca33-4530-a690-86da328fa389', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a9058afe-1ac2-4295-a454-57ddc9e8c935', '9cb30c0b-befb-4fe9-b066-641ec06b7880', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a9058afe-1ac2-4295-a454-57ddc9e8c935', '9b8b4f1f-3b91-49d4-aa1f-d3694a55f08c', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a9058afe-1ac2-4295-a454-57ddc9e8c935', '0ceb7c67-ee89-4ab0-9189-becbbb36acc7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7741f182-daa1-40f4-a3d0-c4b1706b5884', '57f20769-ab20-46af-80e7-101f491f9813', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7741f182-daa1-40f4-a3d0-c4b1706b5884', 'da6c7dc4-a51d-4826-bf03-88a91eaf2a3d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7741f182-daa1-40f4-a3d0-c4b1706b5884', '446066a7-1a98-4e6f-af46-75b13c6982d4', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7741f182-daa1-40f4-a3d0-c4b1706b5884', 'eb72d3a6-b376-4389-9469-c3eacc0500f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7741f182-daa1-40f4-a3d0-c4b1706b5884', 'e7527488-ca33-4530-a690-86da328fa389', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7741f182-daa1-40f4-a3d0-c4b1706b5884', '9cb30c0b-befb-4fe9-b066-641ec06b7880', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7741f182-daa1-40f4-a3d0-c4b1706b5884', '9b8b4f1f-3b91-49d4-aa1f-d3694a55f08c', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7741f182-daa1-40f4-a3d0-c4b1706b5884', '0ceb7c67-ee89-4ab0-9189-becbbb36acc7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('01d43d55-655d-4bfa-8c96-6abf7a9be60c', '57f20769-ab20-46af-80e7-101f491f9813', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('01d43d55-655d-4bfa-8c96-6abf7a9be60c', 'da6c7dc4-a51d-4826-bf03-88a91eaf2a3d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('01d43d55-655d-4bfa-8c96-6abf7a9be60c', '446066a7-1a98-4e6f-af46-75b13c6982d4', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('01d43d55-655d-4bfa-8c96-6abf7a9be60c', 'eb72d3a6-b376-4389-9469-c3eacc0500f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('01d43d55-655d-4bfa-8c96-6abf7a9be60c', 'e7527488-ca33-4530-a690-86da328fa389', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('01d43d55-655d-4bfa-8c96-6abf7a9be60c', '9cb30c0b-befb-4fe9-b066-641ec06b7880', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('01d43d55-655d-4bfa-8c96-6abf7a9be60c', '9b8b4f1f-3b91-49d4-aa1f-d3694a55f08c', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('01d43d55-655d-4bfa-8c96-6abf7a9be60c', '0ceb7c67-ee89-4ab0-9189-becbbb36acc7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a249ae3-dfb6-460a-b488-f44ef5d37554', '57f20769-ab20-46af-80e7-101f491f9813', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a249ae3-dfb6-460a-b488-f44ef5d37554', 'da6c7dc4-a51d-4826-bf03-88a91eaf2a3d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a249ae3-dfb6-460a-b488-f44ef5d37554', '446066a7-1a98-4e6f-af46-75b13c6982d4', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a249ae3-dfb6-460a-b488-f44ef5d37554', 'eb72d3a6-b376-4389-9469-c3eacc0500f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a249ae3-dfb6-460a-b488-f44ef5d37554', 'e7527488-ca33-4530-a690-86da328fa389', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a249ae3-dfb6-460a-b488-f44ef5d37554', '9cb30c0b-befb-4fe9-b066-641ec06b7880', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a249ae3-dfb6-460a-b488-f44ef5d37554', '9b8b4f1f-3b91-49d4-aa1f-d3694a55f08c', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a249ae3-dfb6-460a-b488-f44ef5d37554', '0ceb7c67-ee89-4ab0-9189-becbbb36acc7', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '57f20769-ab20-46af-80e7-101f491f9813', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'da6c7dc4-a51d-4826-bf03-88a91eaf2a3d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '446066a7-1a98-4e6f-af46-75b13c6982d4', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'eb72d3a6-b376-4389-9469-c3eacc0500f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'e7527488-ca33-4530-a690-86da328fa389', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '9cb30c0b-befb-4fe9-b066-641ec06b7880', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '9b8b4f1f-3b91-49d4-aa1f-d3694a55f08c', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '0ceb7c67-ee89-4ab0-9189-becbbb36acc7', false);


--
-- TOC entry 4201 (class 0 OID 17285)
-- Dependencies: 275
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope_role_mapping (scope_id, role_id) VALUES ('f94d82e0-6443-4b99-9aba-a59d70b06323', '125582c9-7be4-424d-b1d3-3e9767809d37');
INSERT INTO public.client_scope_role_mapping (scope_id, role_id) VALUES ('9cb30c0b-befb-4fe9-b066-641ec06b7880', '3b828ec7-2243-425d-8605-60cd2e4850e9');


--
-- TOC entry 4143 (class 0 OID 16409)
-- Dependencies: 217
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4188 (class 0 OID 17055)
-- Dependencies: 262
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4166 (class 0 OID 16761)
-- Dependencies: 240
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4180 (class 0 OID 16939)
-- Dependencies: 254
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4144 (class 0 OID 16414)
-- Dependencies: 218
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4189 (class 0 OID 17136)
-- Dependencies: 263
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4219 (class 0 OID 17522)
-- Dependencies: 293
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('6d3f07ef-f705-41df-b117-f2ffda7f2791', 'Trusted Hosts', 'master', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('3dceaa56-390d-4c2f-8db2-60eab4cbcc64', 'Consent Required', 'master', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('dd14c71f-c0d9-49d9-8125-607e2a5288d8', 'Full Scope Disabled', 'master', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('d9288aea-84a1-4e98-8170-f16de7137b58', 'Max Clients Limit', 'master', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('137b5f7c-fc94-4ce5-8751-aaafd1411bad', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('7d17f548-38d5-44cb-9c19-7b7f43f45666', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('7ccff403-40d9-4e88-8f1b-3e355a3379f7', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('7653c703-8fba-4f69-a825-8ef689413d5e', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('92e8ba3d-277b-48f3-9c91-3d7c9c7810da', 'rsa-generated', 'master', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('bccd6ec6-f53f-4377-946e-76d077d095b8', 'rsa-enc-generated', 'master', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('7cab5233-3834-4d18-8301-ed404232e01f', 'hmac-generated', 'master', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('32f5e1af-9dea-4bf9-9122-6544d61028a3', 'aes-generated', 'master', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('75117a1a-70d2-46b5-ae1c-33feaff14bde', 'rsa-generated', 'CRG', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'CRG', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('6dd4756f-a82a-4578-bbbd-fe0f1d3d4c64', 'rsa-enc-generated', 'CRG', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', 'CRG', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('dbf073df-dba0-402f-8b78-668cc0c10b09', 'hmac-generated', 'CRG', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'CRG', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('087cf0af-3945-4bd9-9168-e7c885227548', 'aes-generated', 'CRG', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'CRG', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('a9641f53-5bd8-4409-aa88-a47be5cd6996', 'Trusted Hosts', 'CRG', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CRG', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('294f2825-2f0d-4d0c-a724-575a2f1af33d', 'Consent Required', 'CRG', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CRG', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('f42a74ad-d6a3-42ce-b5fe-990159d139ad', 'Full Scope Disabled', 'CRG', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CRG', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('969d25f3-cc4a-4b1a-9816-21b8a40ad0e2', 'Max Clients Limit', 'CRG', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CRG', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('c161501a-7beb-4b6e-8f27-b32917e404f5', 'Allowed Protocol Mapper Types', 'CRG', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CRG', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('d7135266-44a9-4fc2-9bf3-e1fa2441c797', 'Allowed Client Scopes', 'CRG', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CRG', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('b5dfbe5c-b4b1-4e77-b45f-28eceb5e26da', 'Allowed Protocol Mapper Types', 'CRG', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CRG', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('13f54e20-c28f-4511-a995-29f92f4b6ad5', 'Allowed Client Scopes', 'CRG', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CRG', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('5211330d-cd94-4737-a112-a949ea5f1132', NULL, 'CRG', 'declarative-user-profile', 'org.keycloak.userprofile.UserProfileProvider', 'CRG', NULL);


--
-- TOC entry 4218 (class 0 OID 17517)
-- Dependencies: 292
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d56bb06e-0e68-4940-961e-96c5389b9801', '7ccff403-40d9-4e88-8f1b-3e355a3379f7', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('6a15242d-8ef6-4a02-b5e4-142e4f23c06d', '7ccff403-40d9-4e88-8f1b-3e355a3379f7', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('73cb3161-0651-4ad1-8a6f-f0a97c79fd2a', '7ccff403-40d9-4e88-8f1b-3e355a3379f7', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('2884b84b-9802-464e-a8f5-decb9767e4ad', '7ccff403-40d9-4e88-8f1b-3e355a3379f7', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('33e67f0b-0d80-4841-8ff1-fe96fd445936', '7ccff403-40d9-4e88-8f1b-3e355a3379f7', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('439ad1a0-095b-4723-ae3f-a06b0c87ce03', '7ccff403-40d9-4e88-8f1b-3e355a3379f7', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b6d364d9-5614-4791-8a78-aa5a6bb5762b', '7ccff403-40d9-4e88-8f1b-3e355a3379f7', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('0d468d0f-e3a2-4b36-8336-bb9e5fbe9ece', '7ccff403-40d9-4e88-8f1b-3e355a3379f7', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('4b6a1cbf-bcc2-4046-a873-ffe1c5be645b', 'd9288aea-84a1-4e98-8170-f16de7137b58', 'max-clients', '200');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('aa1f7a7c-3298-4696-be5d-e4b209ff5fca', '7653c703-8fba-4f69-a825-8ef689413d5e', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('ddae7919-6002-4e0f-9a69-446fcce89865', '7d17f548-38d5-44cb-9c19-7b7f43f45666', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('ea8fd1de-1892-416b-90d3-7fe5ae7cb883', '6d3f07ef-f705-41df-b117-f2ffda7f2791', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a1c794bc-74b8-4b4a-830f-31411807f765', '6d3f07ef-f705-41df-b117-f2ffda7f2791', 'client-uris-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('3abeef7a-47e7-426a-84eb-69ec65f1e137', '137b5f7c-fc94-4ce5-8751-aaafd1411bad', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('c07d2086-f8bd-472b-ad23-8152a3da03d7', '137b5f7c-fc94-4ce5-8751-aaafd1411bad', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a2886e73-3505-4b7f-b66f-bdc104e80aa8', '137b5f7c-fc94-4ce5-8751-aaafd1411bad', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('33bab058-1b13-4ac7-8055-1bae4be5f022', '137b5f7c-fc94-4ce5-8751-aaafd1411bad', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('28890bcf-74d5-43e3-8b47-1db0ac6cf41a', '137b5f7c-fc94-4ce5-8751-aaafd1411bad', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('408c0df0-97d5-4e52-8637-a5f93bd75074', '137b5f7c-fc94-4ce5-8751-aaafd1411bad', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('f4c3c95d-a0af-4796-ac5b-e5d2ed3ee00a', '137b5f7c-fc94-4ce5-8751-aaafd1411bad', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('83afcd61-6a10-4fd9-9765-cea4d988923f', '137b5f7c-fc94-4ce5-8751-aaafd1411bad', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a55282cf-7e85-4ced-bafb-9686d8bfb086', '92e8ba3d-277b-48f3-9c91-3d7c9c7810da', 'privateKey', 'MIIEpQIBAAKCAQEApY/Wv0rEs59kVlxNAAbbQrYsyJAb+F0zn7IexDh2d7VWcfsSadr7LVr2zjospduRW4lChCJgXWDRfO1nswq8K1H46eWvjC/5H/nVAf4pyFC6EU67H/gWPIBI2pd0kTLrtfNc0H+zeu16fUb7uhLij6viOP50mDnwt/t+2OH8mwTWFY/PS27iTgc8cdZwSa+dsRQn+DXr4i/tCvxFXpIS/fIiZUk8TQwFhbMf1lYCPgzkvVsHTwwCASvR7tcXrfsMqJaaxI5V5Bcb+a9qyyVgBv3QKyabyyLj5SEa9wqY7c4dwl7GPWJpIXUoPDxt3FFhsUIntyUEVgjh82ns4fNytwIDAQABAoIBAQCEEGHXg1e2hH1wGf5d+Bosc87zSWjWS9ojF91M3lE5mg/Tqdf9Um0rt7TJukPlJWkkoC/L4PQHaHSSd3lRq02ALMomIU5Pv/C0HgBYr5o6rJJPvgKsNKPgLOBwZYHZVMoLAI5XzpWniAk+J0IjIm9Q9WXl2qu8xfMLf3SmolVyfTG4W26lDIOzAzKtGqTPozTcEGKYHZw385dCdy08z1TDOj79AuQAs990mIbK859NC5Vwa5puR0dqwUcSPVmADawW5h90T7XTGQa6BcMTws+tk3lj1UN37qBpZ3PfbcDfseEek7WZMdNSVN24SCWx0kqIgr/HqXoF3hpSPF2dWx8BAoGBAPj0UZv3j1wB3ql2Q5Cl7hRQVYnC8yl9m6+401wPT6jstVnWPeLZ6ulewZMF+Mc2OSl/QdUhBrttvL0FR9DkvTDX8xyGg7lEQYxqtGo5DkzgRLXxibs5xCmf/vTdE5iRxcMmaNUghddBejz2bGxq4FKW8Qj0dmrtks07M8IveRyBAoGBAKo/VtFSYPfOommuFQk5Og3V1dnbGKxHvJl45JNHgnWSkSIPT9Lvr1ZgA1+J9UapnUtJnG0ine+cLnJ4wqRvJp3oyiDwFyC7PlAr77qXEOcHCKx/JZmH+OSb+jAizQSc3/lpWKPMrRsMdWb+lN/k3SEDFszrgcnWbW6So3VkcNM3AoGBAJxJFGprMS47ZkLQIX5PDHToMaq4HdqwJepchyNF4WZUo0xweI1O7G/wsmjP2OuGmL/6SaO4hfdn3pJzHDCBSFu/VblUoKDPvq6d1gDRLK8KI1hs91/31bOj43RozQJ8kL///tO9BQiq7EgVEt/FAGoYo9xRS325Au2f+tAu6UMBAoGAO+lUTQ93bl16TERlxLwt0OaafjMbKK2KElw33BiDMYrlph3LUojkpDnflgR/m2FfKDp8YO+YstS8h641mRZAebuNPjAfg3ZBRIdhssEswpB4HfQUsEXocdLuJXhpu6DVNPk8p1AE7wrgWeFnVK8+njpvEKgkIXpjQlE6UrqI9dsCgYEA4h1WZPiRUPmEtPwbTdCu3LaxEIxe+4xqbbrTP29CLCBl4r1vdp6/jGr24daEd3D75bXGJ8zOSiW0f2rjurK7TgbBQw7ZFHs76fagTH0i2TkUtfeyVnWzvF9d4CSS1cXDmpTKjw6Wuk3Vnw5NMnhGD1D+pxqkYqQTSECFeRzX0a8=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('97e6157c-d3c7-4194-a2b6-5156c1bab509', '92e8ba3d-277b-48f3-9c91-3d7c9c7810da', 'keyUse', 'SIG');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('58be3549-c191-49f7-a7a8-2fa5e514a6a5', '92e8ba3d-277b-48f3-9c91-3d7c9c7810da', 'certificate', 'MIICmzCCAYMCBgGGAQby2DANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwMTMwMDQ1MjU4WhcNMzMwMTMwMDQ1NDM4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQClj9a/SsSzn2RWXE0ABttCtizIkBv4XTOfsh7EOHZ3tVZx+xJp2vstWvbOOiyl25FbiUKEImBdYNF87WezCrwrUfjp5a+ML/kf+dUB/inIULoRTrsf+BY8gEjal3SRMuu181zQf7N67Xp9Rvu6EuKPq+I4/nSYOfC3+37Y4fybBNYVj89LbuJOBzxx1nBJr52xFCf4NeviL+0K/EVekhL98iJlSTxNDAWFsx/WVgI+DOS9WwdPDAIBK9Hu1xet+wyolprEjlXkFxv5r2rLJWAG/dArJpvLIuPlIRr3Cpjtzh3CXsY9YmkhdSg8PG3cUWGxQie3JQRWCOHzaezh83K3AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHJ/dQHSp63JntR22XHDBSyGOemB16ptsdfLi/+WlN/r85CqTw/SwyqD+9kOhFgjEEI4pk9fhDftecknnTEPeMoQWTuYrsRPiivQ7nylvwB+kf+KggrG6LhVfOWzuuvkJs8jCehavIbvKwcBfEqmhOSlkMTeOagQgGtUZuqesVYNkB5hTd+xdOLP/oZtMqR2KFVGOeKrUNvSpGSu4R6c2nkMA/2AMpTKSaru0zjtDTnS6ZBuoVtKk9++GAOTuxjA13FNSuWnAkdux1ZBum+XX5LBG9ofkv42dCPYGrrvqsYEUrkzUs3Sy7hgTPijXJGGMMuorFKoYYv+TR9qPsBZkU4=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('77f399a2-ebae-4c42-84d0-bf5dfe65e606', '92e8ba3d-277b-48f3-9c91-3d7c9c7810da', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('e5454d5a-cf5b-4fa8-9a67-6bfc56d13e4f', '7cab5233-3834-4d18-8301-ed404232e01f', 'kid', 'a49383e9-a78a-4973-8033-768f91e23428');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('ba08ed77-35a3-4437-9048-6a8ed7b056cf', '7cab5233-3834-4d18-8301-ed404232e01f', 'secret', 'meBxjtyPTrTYWxsaui3W9tswSeqfrc19QEfqPlJhQzsoaS00sopyxa0fE1ibMoHnqDe5GV684Gpq0eHNa2O3bg');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b8f53458-654f-43be-a3c1-a104035a2b91', '7cab5233-3834-4d18-8301-ed404232e01f', 'algorithm', 'HS256');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('ede876e6-5431-46e3-ba9d-ab230ff17e7a', '7cab5233-3834-4d18-8301-ed404232e01f', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('5936323f-1aef-46d8-9349-c6a238ecfe44', '32f5e1af-9dea-4bf9-9122-6544d61028a3', 'secret', 'z1OXch9jLWtdoIKUzm-Rhg');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a3467827-1c55-435d-930c-5936cc07a4aa', '32f5e1af-9dea-4bf9-9122-6544d61028a3', 'kid', '275ce797-4356-46cf-9e25-d417c0134b8e');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('48975208-b0d0-4591-9796-7761203585fe', '32f5e1af-9dea-4bf9-9122-6544d61028a3', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('0a158a98-7e17-4a61-9453-c12cb775876e', 'bccd6ec6-f53f-4377-946e-76d077d095b8', 'keyUse', 'ENC');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('657333d0-4be9-4081-a815-4e8770dd0458', 'bccd6ec6-f53f-4377-946e-76d077d095b8', 'privateKey', 'MIIEpQIBAAKCAQEAjZB02tKms/Rn8TADwkP0ysAc5M6YwLyV+iKhxn9uGL6yydLKdCqNwz1I86Adyp51R/1L11Nxv0I8gxrDcoMDf4YOoGa95KvByupBNflbfoUeoRlSqhfHE9G1ZPSa3EcV0sfCcSb3EYIOkNscUqrZrDzYgRIFlLB0c8Vs5lt9wfpO3Ej+3kINT9oPRO7cUKXG6NOu02RHUhTRcc8hCo1KcFjDrO8rx7/arUqJ+i00CjV5QqNJoYC1Yy0Ui3ZEFoVE5r+JcDv/bOB8gqsuF7G0KVNjLB6KC3lJAo/ZLDfXBRu6TN19R/hEUf1TbiUtU0ZQNGumepE0MtBRd3uKl47vXwIDAQABAoIBACSEE7ByT+/xZnJvaTjOILG/9nQK2po0yxb3ofU636JgZmvrBLAMXf7zqwK01ZpzX1tPeiWz745fPo6u86VxKBDX+qPjfK4ko9t8q4+Jn9E1812o04rukTqKiJjfA6c4auexAXYAkBCjFLDG5DpqubVVCJ/ajzf4gEFwtpOBHCJR0pnmFwzzSTTHXdEfPmhShVGjgqEGLCd7uggppuq1yHX8iFBQghZOM1buhjYrYPhJkQqW+0Kvi/9hiP/8VrQniyo+16fxu7Nuw/KsDzbfvQGpZxNkGis4B5VGIlE780HXZJLLpc/lkPEuSzKLyUW4zna+wpERfI5TFUyXcJnoJckCgYEA85WtSP2kj2iijjgMiWlqgD/ksUbD8+XvuDGjZ/PmT32Zk5/ekLIg5yUrUVruEyXo9sKO1Ks1NL1/cPRBkdWeAvDbC/Tsd8JLYOwtq+3Pb7+ZtajtA9n6yIUzAd7yTMCLVzqt4AlR6taTnpZFENB2WQbLIG/PJ7KXdjeBxcfbR+UCgYEAlMea1TlGZkNmxd6yFXzs9aPZEuS73n1s5qxYYTxhD3S5IDK6tMFjgOTRK2/O8Za1+pnDSk7bUxym/DuFtAxSUScQLjV+VB2TIiNqQ0n9Gm3mETR1wIlDN+MtJTWVTvBfKh0Z38q8cj7V5o/HGN5t1UtCZwAkQoFZIgFJJdhl3fMCgYEAkxNWHRNhkGG6fSrkjvfCoYtyt4Ol/5dfphT6uGKxNl/9IgDOrwmPCmIMBMRlqdQjFROmkEyMBLtCvt4M1VRpYxcw+8g4G5uKTgxtCzm9HZlP4zsLWV79qKOch82o+aTsvY+luveFqclEOuY674sfWmPatEwuhaa1A2FCjzw8b+0CgYEAgpDxdnI/L/uys6+OBYGOyruyAvytSsIz0fQp05uTamb7GCCs7XhSBInKbx4+NJIYvgY29n1hyPx6Jx1tZubxTrrDXmofpV4XA3ylAsxpzMnpf+vT8tYDIYbC1cbCc3ZLbcAANv/KhVBTk3VWOqLpLKhRa+cZ6ytst4T9VrMkIrUCgYEA1osjYMn7yxvvUjXMcLcPxfFpuacsEo3yOJglB68gHfHcBUFaXstxVOjXGSK/lVa9zI7zyqwB5EU7yHNqMo9Wtyt1C2728QHJFgxfypQT94XSJLVzP8sQA6pE054GbrtlEW15hraHk0qp3IBHoKzSDhke5As9T2FoilPoPp6gv/g=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('cb6e0e86-2e12-434e-a4f3-d2ca459d7ea9', 'bccd6ec6-f53f-4377-946e-76d077d095b8', 'certificate', 'MIICmzCCAYMCBgGGAQbzcTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwMTMwMDQ1MjU4WhcNMzMwMTMwMDQ1NDM4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCNkHTa0qaz9GfxMAPCQ/TKwBzkzpjAvJX6IqHGf24YvrLJ0sp0Ko3DPUjzoB3KnnVH/UvXU3G/QjyDGsNygwN/hg6gZr3kq8HK6kE1+Vt+hR6hGVKqF8cT0bVk9JrcRxXSx8JxJvcRgg6Q2xxSqtmsPNiBEgWUsHRzxWzmW33B+k7cSP7eQg1P2g9E7txQpcbo067TZEdSFNFxzyEKjUpwWMOs7yvHv9qtSon6LTQKNXlCo0mhgLVjLRSLdkQWhUTmv4lwO/9s4HyCqy4XsbQpU2MsHooLeUkCj9ksN9cFG7pM3X1H+ERR/VNuJS1TRlA0a6Z6kTQy0FF3e4qXju9fAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADVfZgOk/BxblzcoHksNXsBeNhW7DeR1szE5U7EM2jm8eVSKz4rXG/MXY6nXFfzyewz1kYJ/EFqDoi9tbnyRbw3RjUL4NK4Tv5ct5VaKUHi5k6epZQWZVE9ZujtThDdMZLu15zJPLcVTKIiCAYUB4NF46BpQOQ5fdd4ow0Bk6sGGY+ejrpcN8+l26Lj4CeYrHGF31bsSDfbRMYLvTY92A7loLvMRzzqO62sF3t+BdF9uoiJDMKHFnBe7HzSIGlsjemnhuJLzqxZxwJJu+QajyoLv76Psb/aBXdwkkDNdI6X3SYv9+WYA0zIUN2eIBmTOdjMkHceUL9w6gc89PRgMQp0=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('1630c5e5-c1c7-4fe0-9f1d-720836388d90', 'bccd6ec6-f53f-4377-946e-76d077d095b8', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('dd077e21-44b4-4ca0-bdaa-319b0c47b5b9', 'bccd6ec6-f53f-4377-946e-76d077d095b8', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a5c93095-ed57-4ce9-8479-c3a86c2d1f90', '087cf0af-3945-4bd9-9168-e7c885227548', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('1a84efbb-d1c1-4f9d-b843-a231b4941d20', '087cf0af-3945-4bd9-9168-e7c885227548', 'kid', 'a443a25a-dfaf-4275-93ec-b28f61e2ca41');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('7fb78c98-3fba-4c0f-bdf6-4e4f59113b81', '087cf0af-3945-4bd9-9168-e7c885227548', 'secret', 'WmyDG5Kk4_JyS75zhQ7Fzw');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('7469e997-6f02-454e-8524-69961a70798f', 'dbf073df-dba0-402f-8b78-668cc0c10b09', 'kid', '838be21f-cb7c-4c6c-8066-1e0721d29cfc');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('6ce44c34-f13c-4e8d-92fc-699d25f45fa7', 'dbf073df-dba0-402f-8b78-668cc0c10b09', 'secret', 'vo1eZcFGnXGxgA0N1-aJjuiDWLagW6uFVZaC3L3jy249rIXNdLsMDPlaD-uOVUDzumXm04qouri0VFXTtUNvCw');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('cecae319-4d2b-4f99-9e41-5996605e9d53', 'dbf073df-dba0-402f-8b78-668cc0c10b09', 'algorithm', 'HS256');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('11175b47-5f26-429f-92bf-2cf950db10c5', 'dbf073df-dba0-402f-8b78-668cc0c10b09', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('29cbc783-5e8e-417c-8a3b-5529801bd79b', '6dd4756f-a82a-4578-bbbd-fe0f1d3d4c64', 'keyUse', 'ENC');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a2dc4f28-4381-41aa-b623-a5a4b9488178', '6dd4756f-a82a-4578-bbbd-fe0f1d3d4c64', 'certificate', 'MIIClTCCAX0CBgGGAQ04ODANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANDUkcwHhcNMjMwMTMwMDQ1OTQ5WhcNMzMwMTMwMDUwMTI5WjAOMQwwCgYDVQQDDANDUkcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQChRUypvG/7/ohngKDYM3jPsRUSRdpIZjVzzi+0A6KNFi6ieCsXLEoZvJdf/EXpMUMX4EhhFC7m0E0Vho7+FQ42cjYp+X1TXUo477BxYmVg6v+9NBNLKZSVt0PAG4HpeRPh0pibzmJW7NUV1V/FyE8qkFcljnxMHXMZvZR+Tt+Qub18t0Nsx7w9VystZbDir4k3RTpXpfE6If3hT1BZCNJBXOnubtbT1l5ZEpUn/HTYSiC7HwTK+MlRFAsoSC/9tvdIaelpySE6zeaLrLjQwdUTvpgB3nU0qJ6ENjT2Nt7TXHJszs9i4eYj1WTXkCj5pds9T58EgpTgwbeitCJ28/lRAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHXhy7o7csirpa/Q0w0v/F7nfakHeLFC0w9NWIrxsDWCzAgRiygsvTvG4yXQLv3BqqJu3hdMYs/5uF932DMo7GBitWhLOkNFeu+2It5CjX07LC+KqP+rAXqcuNG76LAN07ogBYwl+Yaq2muXpu5ZprEdw2sT18hBouUZUL0Gd7qHKkkL/zQMz4v//gKwaFNQyTqeVVzq00LGnqgww/hEyoK65w7HJPiXSIR52d8Mxwd0QUl7tkXy58p9uWdtUne2MTPN3HmZT9min1ekAxhtwwsA0jYF7EB4G+FtedVRDBY6CgaQyjvsUnmqVjRhx/0ypw5QVQmpogBx5fg9hvwv7p4=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('265e5d5e-0943-48bf-ad88-cb83ec1582f6', '6dd4756f-a82a-4578-bbbd-fe0f1d3d4c64', 'privateKey', 'MIIEogIBAAKCAQEAoUVMqbxv+/6IZ4Cg2DN4z7EVEkXaSGY1c84vtAOijRYuongrFyxKGbyXX/xF6TFDF+BIYRQu5tBNFYaO/hUONnI2Kfl9U11KOO+wcWJlYOr/vTQTSymUlbdDwBuB6XkT4dKYm85iVuzVFdVfxchPKpBXJY58TB1zGb2Ufk7fkLm9fLdDbMe8PVcrLWWw4q+JN0U6V6XxOiH94U9QWQjSQVzp7m7W09ZeWRKVJ/x02Eogux8EyvjJURQLKEgv/bb3SGnpackhOs3mi6y40MHVE76YAd51NKiehDY09jbe01xybM7PYuHmI9Vk15Ao+aXbPU+fBIKU4MG3orQidvP5UQIDAQABAoIBACM8T+66BEGrsEPk/7+dJ2VBjJgMeQ/efQlLYHLVZHutAA1xcgDDJYGQCgbnyKKVp9Icp9PGJCU8F8t/Ndjf4tYUiC8NmstPE7ty6zsqw3m0fqHpMdn3QMahXwUnPXA0ixqI99z679OMNVZq410EUf+7v76t7gx3VsGmAT7DnucwxKBInVK+YbrIbKfoRViNITE6luypoA5SsQTV94GV3aeOwvQF1+XFrJRX86BCNW2ngdmvt7mritSJmBetjQOfvsifh0GS6b4pgnVN/a7WMhHCYrS3d4Jpkl0lFgIj7WrlOYDPS9Zn4FJoLwPRLXfwpDAJ9uQIy+hqONMOEwtC9w0CgYEA4irXBkWJwa4X2jWVWM5nMDe1nwRobgnlk8IE0BRY//X2Ed+FRCyj/z8XT1s0P9vhE4BrMJK9N/aZbyK2P2RghNnp62G17oumqKsKcQuEp6pCo7eX3ns555TPA1e1zxg4xHTZnF8JE6wA7QOVpzGpKUE3vbBe7R+CEpUlHKXZcUsCgYEAtosL7DYtAPUCEzppd7D6UDIbYHunRJRSz1uc4NrpcGctX7SBV/KPx5B4PimAic2kSp69UKVgDG0woq9+AtBaiKpsL211xgStw+EE6ldg9CFxuDL+u047g9gLwuBsOSPy2MA3ewjJWChDJTZS6QbKr+832RGjLruLCI8SOujT+lMCgYBvtHsJhPT6LTNoukhuWVuL7CgPR00Q9GBor05TO4mNunzz7PNUbbv+SLoJnuFanQ445JeMoR1F881qn7ll6/zkAQFRGayTCnShIAGDPg4iBazuUbJ312MNJ2lrnDmW9L6tAY2tdx7zkWPPrJKQxq1nS+ftD5yC/6nt5a4zzRJtqwKBgETeHohmRAJJbRf+AI5EeZtJ3CRBYnCwGLHcWUpHrKxYcLjbq7SXcYET0xl4pOLYb3QrgTbsvVjS1Pd7h+nd21oWGaym+jjTyQ7OVQFoJ87S00lwC8R0lmV+W6mQ66N/GX6Gvievv+5/eh2O6ia6Bjvr30EIs2zNGn4HJBSPhHG7AoGAb+bvMYBz/ayrA0of78miVdX3/veFVUc/tn/FT3NE62K1cv2fi0ChDwEJ+S0kvJNeiT87mgdFArMqTKminH0HnCctcPTIUeQu1+iIm4kk+vK28njhy/WVY+BGP2mAPREjhU35hgHsf5bxdcb+VcSuHZp/rLNxA9rw7oqQe6FHNro=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a7596de0-10d6-4b3f-8d31-f3c4c60ef2bf', '6dd4756f-a82a-4578-bbbd-fe0f1d3d4c64', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('93a39764-c15b-453b-8940-72722b1cd01b', '6dd4756f-a82a-4578-bbbd-fe0f1d3d4c64', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('393fc858-d247-4552-8481-6538c786c0a2', '75117a1a-70d2-46b5-ae1c-33feaff14bde', 'keyUse', 'SIG');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('e32b3317-588f-474c-8c0e-d5e24dd905e3', '75117a1a-70d2-46b5-ae1c-33feaff14bde', 'privateKey', 'MIIEowIBAAKCAQEAsFC3YNfWXEy66zaiEv/Oe3XqoQEJ+yO3hQQkrh7UwtAF2eskphu+qIk/gnZnbs1hlEC2lftqycD+4PiK07usulkLDUe7/J5y8x5ugHhcWFQ1geoX1fN+6nulgfpOpANfwirNr/e+NLhoW14bjKiLbcMAPgJXJqkVvEVK7eJAOtWqJRawEcjFUomNVSCRYkiCxqFPbHRcan3nNysD3cFRsNlPEZZ9yWGA5gm90fQK6GcZy1/Ub0XjzPCjYqUZNIEVyQSnkG0GpOW2IHGsmohxGOE7r2TVZiSbSZ5r7VpNEF5dUl6d/kRXV9E+uaYElQ1mnuGEuHaFpIrPRSEJpLDBxQIDAQABAoIBAEJiMZkJytC3pwzWZhFnNPPxAqUaAgsHeJphY/oW655pujpBOWw9N/y2qC3TrL/gHiQ2dUhk/+D0hEJp8cMkfzUuP2YBozrK4Za913cRWht7oSXH4K+SXS+l3Dvi5WcFSjGN8iGV0oyA/fGgrhi4gL6T0+yE7xFESkW3hS2pqOs9VR1gF6J1eD4DAKoPgHpRiC5UM33cGTirVuKxDcBeXN3kfEkYGERhAXSXUdbuY4ea10SU81GFLXZduPvU4UuVQqmfAAT6T11UE+oRxb5oKBSGgmBpVTc4XzeFGJ5zDHFS+TJhSnSPXp+Rl6wh7DamR5qhjG6PE9PqVi8UhhnKY0ECgYEA2+54kCkpXXwJc+h9G4eeBYLtaIp3pNWeej5v3J3RGYGUc28zBiEqPXhOOspQS6LK/5c99VjS3c1ElSb8V0VSnHl8MrQCczeMrEHZ/pVkI/fpuL9gZJVKsN0D/UKCzDvLruyyBGfJRU59RV4FmBQP8GE8rZ5Ozc1SQxOFFG2lFzECgYEAzTsTpAbn5eCSZMFzjdJtoAg4OZHjFHhd/k1xSj1lND/6r6Yz2nZklSKMT+O1hmBM7DJzBlS5eriE8E5gfCCaBxL9ICvP0hsCGt9VFdw+veWF6FpPmaKdXQldRV6kTerACOdlhf3BCWUSH0qTFqqmhI8dv5TKjuF63N/2RO6qVtUCgYEAoX8PUOyoz1jRqCdEFv8S7oEhy+5BxOyIHsPSaHIKpWwdklZJZWrdFZ5N86W0KJY18lEg0hSTYwPkJJIoIf1pmDUtGh5M3kYgKi2A4gzZKABXw63kHnfyDMV+tG4ulcIi4yQz5EBB736fRlywRugUfDMq12K0AzOOAGtJAaMx40ECgYAOSgW1DvIIdFldAIceIb+WO9xGTd0EqNjKgvPXWmz4dVfr8ON9W27nX09rpIwX/g59B4owr6d2XvCKlrprCg4PXggXvFUs6Mp9unz/F6WarSdkpR0TslnIh4Vh9hP0hNq4A/xyltdg4xOe8B9LnbgYVKqaky6DQjm+tS09YWykvQKBgALDc8gf8SDGSfgOYCo2nnVy/K1GKQTi/nkmbS4rx0iJzZu/Z8JuaSfn6O2EOx/v55rr8X5HfUsVCg+5qhJz7ej9XDFCvpZOvjJjeaV1af8sde0IH7odricCakPPKWRQGxDsFpfn7RTbG/1s5Qpx+D5hGLak4BK0dlNoXqZ4tXUm');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('1302be62-efea-4816-a15d-6792ec782b72', '75117a1a-70d2-46b5-ae1c-33feaff14bde', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('c6350fec-ceb5-4c3f-8ffe-8b3ff8518dbb', '75117a1a-70d2-46b5-ae1c-33feaff14bde', 'certificate', 'MIIClTCCAX0CBgGGAQ04EDANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANDUkcwHhcNMjMwMTMwMDQ1OTQ4WhcNMzMwMTMwMDUwMTI4WjAOMQwwCgYDVQQDDANDUkcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCwULdg19ZcTLrrNqIS/857deqhAQn7I7eFBCSuHtTC0AXZ6ySmG76oiT+CdmduzWGUQLaV+2rJwP7g+IrTu6y6WQsNR7v8nnLzHm6AeFxYVDWB6hfV837qe6WB+k6kA1/CKs2v9740uGhbXhuMqIttwwA+AlcmqRW8RUrt4kA61aolFrARyMVSiY1VIJFiSILGoU9sdFxqfec3KwPdwVGw2U8Rln3JYYDmCb3R9AroZxnLX9RvRePM8KNipRk0gRXJBKeQbQak5bYgcayaiHEY4TuvZNVmJJtJnmvtWk0QXl1SXp3+RFdX0T65pgSVDWae4YS4doWkis9FIQmksMHFAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEJ0x1uEcNxxlwkKXxsUU6p8MhUrSodqH3j2h9K3+OnWVgKlSWgAqISxxo+wnJZLvpv3aidYFQKOlB4gQe5y2VpgoGItF/qHk+ceHcMPULsXJBAA4YOTbsU6EvPQYIxFqtJ5pJvndvb3EvaW/pd3V7/GN01aCSJd48TXuFOzrOdM2zqlRzMgfHgByGpvvBM4A2Xo4ql2Dtfnugqzxc1Xv0bVRKS0xvAirL/jyMI3YsQCqWHMJpSw4IO2fnePYKIrSppi78gtKduIhbrxi7yC5LOJkCME4QhY0A5QqElAGAQ198WBnuBWAxFa1uaNEaOvwBx4fxAnECwNELozqaRFoNs=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d4cce167-5ac1-46a5-8468-d33ce3b58daa', '13f54e20-c28f-4511-a995-29f92f4b6ad5', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('094b0f31-574a-4857-bfec-72444cea39e0', 'd7135266-44a9-4fc2-9bf3-e1fa2441c797', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('172ec824-71be-4569-81d7-c5f7d76477d2', 'b5dfbe5c-b4b1-4e77-b45f-28eceb5e26da', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b04ec8e4-0836-4ce2-bb5f-606e74106348', 'b5dfbe5c-b4b1-4e77-b45f-28eceb5e26da', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('7f3a8ab0-ff7e-4748-9988-a599836f928b', 'b5dfbe5c-b4b1-4e77-b45f-28eceb5e26da', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('901229e4-d4ac-4bfb-9ab5-28baca7a34c6', 'b5dfbe5c-b4b1-4e77-b45f-28eceb5e26da', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('856a5d49-d5f0-4292-8d9e-fbb2fe7cd28b', 'b5dfbe5c-b4b1-4e77-b45f-28eceb5e26da', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d51dcd79-3dd2-4a5a-9ee0-5eef565b1d5f', 'b5dfbe5c-b4b1-4e77-b45f-28eceb5e26da', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('302c1a18-087b-4875-8eb8-69945df4a722', 'b5dfbe5c-b4b1-4e77-b45f-28eceb5e26da', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('274b3a6e-829b-4171-9c26-c4ef9be12c5e', 'b5dfbe5c-b4b1-4e77-b45f-28eceb5e26da', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('def597c9-7e85-4611-973b-12a3d53fb4f3', 'a9641f53-5bd8-4409-aa88-a47be5cd6996', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('570fe36d-15f4-4d87-82cc-14e75e8432e1', 'a9641f53-5bd8-4409-aa88-a47be5cd6996', 'client-uris-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('55c23511-7a31-4671-8eda-44105fd6d3e6', '969d25f3-cc4a-4b1a-9816-21b8a40ad0e2', 'max-clients', '200');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('8cd99cdd-ddea-4d2d-826f-110ea5117fdd', 'c161501a-7beb-4b6e-8f27-b32917e404f5', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('7953f46d-ddc8-4239-9e80-f74d16c73e2e', 'c161501a-7beb-4b6e-8f27-b32917e404f5', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('ceac4711-45dd-491c-b5e6-f5cde2cb0f26', 'c161501a-7beb-4b6e-8f27-b32917e404f5', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('3065fffa-4963-4987-b613-48c031f01755', 'c161501a-7beb-4b6e-8f27-b32917e404f5', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('4d4bc605-f811-4691-adfe-16fd02fa866c', 'c161501a-7beb-4b6e-8f27-b32917e404f5', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('39de39e4-b403-4733-a360-0c1087d3cb58', 'c161501a-7beb-4b6e-8f27-b32917e404f5', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('df11b113-ec16-44e2-a57f-dc22463101cb', 'c161501a-7beb-4b6e-8f27-b32917e404f5', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('79c0f1ef-1f8b-4d20-98d4-5dd04d2f03c3', 'c161501a-7beb-4b6e-8f27-b32917e404f5', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');


--
-- TOC entry 4145 (class 0 OID 16417)
-- Dependencies: 219
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '8444d31d-84bb-418b-9a0a-b49a26b9b70f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'cbf8b5f0-2627-4f21-92af-5d6aae50e5d1');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '13360936-f42e-4085-a33f-425fc4423147');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'dd830b3d-902f-49ce-a881-f1c25544e80e');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'b3ccf2ba-24a1-48ef-bd3a-b442e654a4fc');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '2e4ab954-17d2-4882-88ee-6ba70321daf0');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'ee5c4a8b-afc9-43ae-a172-b56b5462b8fa');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '580aa5c0-f96b-4cdc-9d1c-4b34009c5ae2');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'b64595a5-66ad-4677-9eff-861fecc64f19');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '14c011d7-a582-44ea-b44e-784f9783fcc6');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '70acc01d-f669-473d-b314-b46488074750');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '8a048125-5764-4d1d-a892-cbfa6c7bed66');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'f91c0a14-0b6c-4c21-bc6b-ce9c13e497d7');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'dc58c01f-290c-4c3f-96b9-7af787f9aa6f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'c5981d9e-6446-43cd-a158-8e98bef5f8ab');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '27285100-afd2-42a2-a2c0-671aaf5ae66d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '9f746ee4-dd4d-4b35-9ee2-47979ef8eeb4');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'c8555230-f58f-4a75-a37e-c603535f3ada');
INSERT INTO public.composite_role (composite, child_role) VALUES ('b3ccf2ba-24a1-48ef-bd3a-b442e654a4fc', '27285100-afd2-42a2-a2c0-671aaf5ae66d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('dd830b3d-902f-49ce-a881-f1c25544e80e', 'c5981d9e-6446-43cd-a158-8e98bef5f8ab');
INSERT INTO public.composite_role (composite, child_role) VALUES ('dd830b3d-902f-49ce-a881-f1c25544e80e', 'c8555230-f58f-4a75-a37e-c603535f3ada');
INSERT INTO public.composite_role (composite, child_role) VALUES ('76c71245-4328-4c0e-8efc-0ba93dd9cae5', '8d9b8596-c58b-471b-b3cb-cbca6d928fbb');
INSERT INTO public.composite_role (composite, child_role) VALUES ('76c71245-4328-4c0e-8efc-0ba93dd9cae5', 'f03b89ac-8890-49f4-88b4-e0ca69298469');
INSERT INTO public.composite_role (composite, child_role) VALUES ('f03b89ac-8890-49f4-88b4-e0ca69298469', 'd4f55ce7-3221-4719-954a-de94b334044a');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99262a04-9b09-469a-9354-1eb1a267282b', 'bd929c6f-ead4-49ee-b081-31c10cf8cb08');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '27af635b-1cb8-4a37-a847-b50a44d573af');
INSERT INTO public.composite_role (composite, child_role) VALUES ('76c71245-4328-4c0e-8efc-0ba93dd9cae5', '125582c9-7be4-424d-b1d3-3e9767809d37');
INSERT INTO public.composite_role (composite, child_role) VALUES ('76c71245-4328-4c0e-8efc-0ba93dd9cae5', '0ef31d4e-787c-431e-a4f9-1ff99a9dc215');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '1444d754-6055-47de-b7af-de2ca30a7536');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '0dbb8d9e-9d98-4808-9a46-c9cc75cc8969');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '9e77084c-2977-46a8-bf97-b0f9dd0b618c');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'bd8bdfc9-b33c-4ce8-aceb-45d5a1a102e4');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'ce57c72c-892a-42e1-ae2d-aa8d86ad003e');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'd91e26b4-3955-47a2-b89c-92a4639ba6af');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'b123360b-b6b2-4e5e-8a24-c3a5ac0fdb56');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '833bbc53-d5dc-4775-b0eb-3b5f56f53ddb');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '0edfb085-e9de-4cfc-ab4c-f3c834518337');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '9dd86adc-f341-4205-9707-536e026e02e5');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '1678aa44-a238-4de5-8e4c-79ad471d8991');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '71080794-64c2-4ccf-a22c-a5b7473bbc7a');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '47940d42-7ca8-4ed1-8407-40cd20c42599');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '43f5c2c2-d25b-42b3-bdd9-6ed4e906637d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '521d2448-460d-4fb2-8a59-4958b9af57a7');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '0de404e7-9322-460a-a1bb-75c38b0ff249');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '91fde41e-a650-4238-b085-0dfac2cbc06f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('bd8bdfc9-b33c-4ce8-aceb-45d5a1a102e4', '521d2448-460d-4fb2-8a59-4958b9af57a7');
INSERT INTO public.composite_role (composite, child_role) VALUES ('9e77084c-2977-46a8-bf97-b0f9dd0b618c', '91fde41e-a650-4238-b085-0dfac2cbc06f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('9e77084c-2977-46a8-bf97-b0f9dd0b618c', '43f5c2c2-d25b-42b3-bdd9-6ed4e906637d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', 'bf54e3d7-3bfd-4eb5-8b98-f95400e488f4');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '9d968aae-c989-4a10-acca-b9e08020dc1f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '971f077e-86db-4dbf-966d-76254fe9bbfa');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '999a5e0d-ea18-446f-a6d4-e8e191a62dca');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '33b2407a-7e56-40eb-9c93-4a1f2a693b53');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', 'a0292efd-4276-465c-a803-279a05c2b0d3');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '977b0882-b274-403c-bf6b-af68c45d3267');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '8092d763-42a5-42e6-8358-c72b1bf46738');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '93ef9e8b-0510-4f74-b4b1-10f166757419');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', 'e37c9b71-0f80-4777-ba1a-ce2426f12998');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '5eb82123-9918-4480-adcf-2c6677678c0b');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '017dcbbc-24ed-41d7-a52f-af655fb492f4');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '2e79de55-b59a-4409-9cb7-330ddd7614a8');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '722e35ec-c7ad-45d8-8904-e8938f28c4d0');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', 'a44a56b0-6865-44b4-81e0-72cf41fbb163');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '8fdb94af-1a19-497c-b194-788b8dd3468d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '856881a1-8944-47fe-9afe-3fcce43c603f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('999a5e0d-ea18-446f-a6d4-e8e191a62dca', 'a44a56b0-6865-44b4-81e0-72cf41fbb163');
INSERT INTO public.composite_role (composite, child_role) VALUES ('971f077e-86db-4dbf-966d-76254fe9bbfa', '722e35ec-c7ad-45d8-8904-e8938f28c4d0');
INSERT INTO public.composite_role (composite, child_role) VALUES ('971f077e-86db-4dbf-966d-76254fe9bbfa', '856881a1-8944-47fe-9afe-3fcce43c603f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('59a0fcbc-58e9-49d9-a13b-bad975f4ae0c', 'fb5c7018-fdcb-41b3-b110-ae36285905be');
INSERT INTO public.composite_role (composite, child_role) VALUES ('59a0fcbc-58e9-49d9-a13b-bad975f4ae0c', '1408df24-7005-4e50-8e3b-9bfe74d0cccf');
INSERT INTO public.composite_role (composite, child_role) VALUES ('1408df24-7005-4e50-8e3b-9bfe74d0cccf', 'c1a9f03b-3459-459e-b16e-c568c505e627');
INSERT INTO public.composite_role (composite, child_role) VALUES ('38d5c2fa-1a94-4a44-a52f-7244eabfdb59', '9ff8d5cc-a5d5-4d34-9b05-4c843b231dd2');
INSERT INTO public.composite_role (composite, child_role) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '41d32941-4bea-4b35-9ad7-f5391660f52a');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '8a4e694a-f869-4752-8371-a6be8f1f6677');
INSERT INTO public.composite_role (composite, child_role) VALUES ('59a0fcbc-58e9-49d9-a13b-bad975f4ae0c', '3b828ec7-2243-425d-8605-60cd2e4850e9');
INSERT INTO public.composite_role (composite, child_role) VALUES ('59a0fcbc-58e9-49d9-a13b-bad975f4ae0c', '530ab842-3c42-4db1-9eb2-80fb0bba79f5');


--
-- TOC entry 4146 (class 0 OID 16420)
-- Dependencies: 220
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('915128dc-91fa-4beb-83f7-b8bef9e8d0a8', NULL, 'password', '4db55130-e611-4120-9323-00f7c1eac083', 1675054478754, NULL, '{"value":"TIPOqpEtIybNI2tUiqyUmrfwaH7OvpQgz3uQK10swYSrc7sy+Y1ZnsgCT3ZfsvlxQM7ySWTBtU7q5MyS0I2x3g==","salt":"M3RRhTGWi6gXKJVEcANGYQ==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('a249faf0-9108-4764-9094-7f35b923a1fd', NULL, 'password', '8b38bb92-f228-4ecf-900b-12649c2a77a9', 1675055360908, NULL, '{"value":"EbJ6ae330eQWC/8vnlKtv4MD07ThB/hLfKyLh3rMdEitTibN9Sm34lE6jJucMss4of1MJRmDFIorCToFTTM0nw==","salt":"ik3yYBppYWf4NSmtQgMGXQ==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);


--
-- TOC entry 4141 (class 0 OID 16390)
-- Dependencies: 215
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2023-01-30 04:54:27.575131', 1, 'EXECUTED', '7:4e70412f24a3f382c82183742ec79317', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2023-01-30 04:54:27.589112', 2, 'MARK_RAN', '7:cb16724583e9675711801c6875114f28', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2023-01-30 04:54:27.672125', 3, 'EXECUTED', '7:0310eb8ba07cec616460794d42ade0fa', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2023-01-30 04:54:27.679745', 4, 'EXECUTED', '7:5d25857e708c3233ef4439df1f93f012', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2023-01-30 04:54:27.903318', 5, 'EXECUTED', '7:c7a54a1041d58eb3817a4a883b4d4e84', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2023-01-30 04:54:27.910104', 6, 'MARK_RAN', '7:2e01012df20974c1c2a605ef8afe25b7', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2023-01-30 04:54:28.075208', 7, 'EXECUTED', '7:0f08df48468428e0f30ee59a8ec01a41', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2023-01-30 04:54:28.084992', 8, 'MARK_RAN', '7:a77ea2ad226b345e7d689d366f185c8c', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2023-01-30 04:54:28.091879', 9, 'EXECUTED', '7:a3377a2059aefbf3b90ebb4c4cc8e2ab', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2023-01-30 04:54:28.308762', 10, 'EXECUTED', '7:04c1dbedc2aa3e9756d1a1668e003451', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2023-01-30 04:54:28.406211', 11, 'EXECUTED', '7:36ef39ed560ad07062d956db861042ba', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2023-01-30 04:54:28.40997', 12, 'MARK_RAN', '7:d909180b2530479a716d3f9c9eaea3d7', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2023-01-30 04:54:28.433113', 13, 'EXECUTED', '7:cf12b04b79bea5152f165eb41f3955f6', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2023-01-30 04:54:28.47212', 14, 'EXECUTED', '7:7e32c8f05c755e8675764e7d5f514509', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2023-01-30 04:54:28.474896', 15, 'MARK_RAN', '7:980ba23cc0ec39cab731ce903dd01291', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2023-01-30 04:54:28.477289', 16, 'MARK_RAN', '7:2fa220758991285312eb84f3b4ff5336', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2023-01-30 04:54:28.479803', 17, 'EXECUTED', '7:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2023-01-30 04:54:28.575262', 18, 'EXECUTED', '7:91ace540896df890cc00a0490ee52bbc', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2023-01-30 04:54:28.66785', 19, 'EXECUTED', '7:c31d1646dfa2618a9335c00e07f89f24', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2023-01-30 04:54:28.677378', 20, 'EXECUTED', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-01-30 04:54:30.553017', 45, 'EXECUTED', '7:6a48ce645a3525488a90fbf76adf3bb3', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2023-01-30 04:54:28.680458', 21, 'MARK_RAN', '7:f987971fe6b37d963bc95fee2b27f8df', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2023-01-30 04:54:28.6862', 22, 'MARK_RAN', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2023-01-30 04:54:28.75629', 23, 'EXECUTED', '7:ed2dc7f799d19ac452cbcda56c929e47', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2023-01-30 04:54:28.763185', 24, 'EXECUTED', '7:80b5db88a5dda36ece5f235be8757615', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2023-01-30 04:54:28.765495', 25, 'MARK_RAN', '7:1437310ed1305a9b93f8848f301726ce', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2023-01-30 04:54:29.040216', 26, 'EXECUTED', '7:b82ffb34850fa0836be16deefc6a87c4', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2023-01-30 04:54:29.228926', 27, 'EXECUTED', '7:9cc98082921330d8d9266decdd4bd658', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2023-01-30 04:54:29.240531', 28, 'EXECUTED', '7:03d64aeed9cb52b969bd30a7ac0db57e', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2023-01-30 04:54:29.374585', 29, 'EXECUTED', '7:f1f9fd8710399d725b780f463c6b21cd', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2023-01-30 04:54:29.403924', 30, 'EXECUTED', '7:53188c3eb1107546e6f765835705b6c1', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2023-01-30 04:54:29.432539', 31, 'EXECUTED', '7:d6e6f3bc57a0c5586737d1351725d4d4', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2023-01-30 04:54:29.439112', 32, 'EXECUTED', '7:454d604fbd755d9df3fd9c6329043aa5', 'customChange', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2023-01-30 04:54:29.445992', 33, 'EXECUTED', '7:57e98a3077e29caf562f7dbf80c72600', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2023-01-30 04:54:29.448896', 34, 'MARK_RAN', '7:e4c7e8f2256210aee71ddc42f538b57a', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2023-01-30 04:54:29.502391', 35, 'EXECUTED', '7:09a43c97e49bc626460480aa1379b522', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2023-01-30 04:54:29.508959', 36, 'EXECUTED', '7:26bfc7c74fefa9126f2ce702fb775553', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2023-01-30 04:54:29.51776', 37, 'EXECUTED', '7:a161e2ae671a9020fff61e996a207377', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2023-01-30 04:54:29.522793', 38, 'EXECUTED', '7:37fc1781855ac5388c494f1442b3f717', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2023-01-30 04:54:29.527126', 39, 'EXECUTED', '7:13a27db0dae6049541136adad7261d27', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2023-01-30 04:54:29.529502', 40, 'MARK_RAN', '7:550300617e3b59e8af3a6294df8248a3', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2023-01-30 04:54:29.531805', 41, 'MARK_RAN', '7:e3a9482b8931481dc2772a5c07c44f17', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2023-01-30 04:54:29.53843', 42, 'EXECUTED', '7:72b07d85a2677cb257edb02b408f332d', 'customChange', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2023-01-30 04:54:30.536538', 43, 'EXECUTED', '7:a72a7858967bd414835d19e04d880312', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2023-01-30 04:54:30.545179', 44, 'EXECUTED', '7:94edff7cf9ce179e7e85f0cd78a3cf2c', 'addColumn tableName=USER_ENTITY', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-01-30 04:54:30.561901', 46, 'EXECUTED', '7:e64b5dcea7db06077c6e57d3b9e5ca14', 'customChange', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-01-30 04:54:30.564967', 47, 'MARK_RAN', '7:fd8cf02498f8b1e72496a20afc75178c', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-01-30 04:54:30.707511', 48, 'EXECUTED', '7:542794f25aa2b1fbabb7e577d6646319', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-01-30 04:54:30.716304', 49, 'EXECUTED', '7:edad604c882df12f74941dac3cc6d650', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2023-01-30 04:54:30.812523', 50, 'EXECUTED', '7:0f88b78b7b46480eb92690cbf5e44900', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2023-01-30 04:54:31.060847', 51, 'EXECUTED', '7:d560e43982611d936457c327f872dd59', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2023-01-30 04:54:31.067022', 52, 'EXECUTED', '7:c155566c42b4d14ef07059ec3b3bbd8e', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2023-01-30 04:54:31.071398', 53, 'EXECUTED', '7:b40376581f12d70f3c89ba8ddf5b7dea', 'update tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2023-01-30 04:54:31.075245', 54, 'EXECUTED', '7:a1132cc395f7b95b3646146c2e38f168', 'update tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2023-01-30 04:54:31.087919', 55, 'EXECUTED', '7:d8dc5d89c789105cfa7ca0e82cba60af', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2023-01-30 04:54:31.106975', 56, 'EXECUTED', '7:7822e0165097182e8f653c35517656a3', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2023-01-30 04:54:31.162132', 57, 'EXECUTED', '7:c6538c29b9c9a08f9e9ea2de5c2b6375', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2023-01-30 04:54:31.50827', 58, 'EXECUTED', '7:6d4893e36de22369cf73bcb051ded875', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2023-01-30 04:54:31.567041', 59, 'EXECUTED', '7:57960fc0b0f0dd0563ea6f8b2e4a1707', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2023-01-30 04:54:31.578973', 60, 'EXECUTED', '7:2b4b8bff39944c7097977cc18dbceb3b', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2023-01-30 04:54:31.592465', 61, 'EXECUTED', '7:2aa42a964c59cd5b8ca9822340ba33a8', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2023-01-30 04:54:31.600458', 62, 'EXECUTED', '7:9ac9e58545479929ba23f4a3087a0346', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2023-01-30 04:54:31.605539', 63, 'EXECUTED', '7:14d407c35bc4fe1976867756bcea0c36', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2023-01-30 04:54:31.609697', 64, 'EXECUTED', '7:241a8030c748c8548e346adee548fa93', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2023-01-30 04:54:31.613111', 65, 'EXECUTED', '7:7d3182f65a34fcc61e8d23def037dc3f', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2023-01-30 04:54:31.655311', 66, 'EXECUTED', '7:b30039e00a0b9715d430d1b0636728fa', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2023-01-30 04:54:31.680151', 67, 'EXECUTED', '7:3797315ca61d531780f8e6f82f258159', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2023-01-30 04:54:31.685647', 68, 'EXECUTED', '7:c7aa4c8d9573500c2d347c1941ff0301', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2023-01-30 04:54:31.716594', 69, 'EXECUTED', '7:b207faee394fc074a442ecd42185a5dd', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2023-01-30 04:54:31.725124', 70, 'EXECUTED', '7:ab9a9762faaba4ddfa35514b212c4922', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2023-01-30 04:54:31.729689', 71, 'EXECUTED', '7:b9710f74515a6ccb51b72dc0d19df8c4', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-01-30 04:54:31.736237', 72, 'EXECUTED', '7:ec9707ae4d4f0b7452fee20128083879', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-01-30 04:54:31.745095', 73, 'EXECUTED', '7:3979a0ae07ac465e920ca696532fc736', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-01-30 04:54:31.747055', 74, 'MARK_RAN', '7:5abfde4c259119d143bd2fbf49ac2bca', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-01-30 04:54:31.793584', 75, 'EXECUTED', '7:b48da8c11a3d83ddd6b7d0c8c2219345', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-01-30 04:54:31.822008', 76, 'EXECUTED', '7:a73379915c23bfad3e8f5c6d5c0aa4bd', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2023-01-30 04:54:31.826853', 77, 'EXECUTED', '7:39e0073779aba192646291aa2332493d', 'addColumn tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2023-01-30 04:54:31.829163', 78, 'MARK_RAN', '7:81f87368f00450799b4bf42ea0b3ec34', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2023-01-30 04:54:31.870057', 79, 'EXECUTED', '7:20b37422abb9fb6571c618148f013a15', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2023-01-30 04:54:31.872818', 80, 'MARK_RAN', '7:1970bb6cfb5ee800736b95ad3fb3c78a', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-01-30 04:54:31.894787', 81, 'EXECUTED', '7:45d9b25fc3b455d522d8dcc10a0f4c80', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-01-30 04:54:31.897426', 82, 'MARK_RAN', '7:890ae73712bc187a66c2813a724d037f', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-01-30 04:54:31.906392', 83, 'EXECUTED', '7:0a211980d27fafe3ff50d19a3a29b538', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-01-30 04:54:31.908738', 84, 'MARK_RAN', '7:a161e2ae671a9020fff61e996a207377', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-01-30 04:54:31.930865', 85, 'EXECUTED', '7:01c49302201bdf815b0a18d1f98a55dc', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2023-01-30 04:54:31.940692', 86, 'EXECUTED', '7:3dace6b144c11f53f1ad2c0361279b86', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2023-01-30 04:54:31.957816', 87, 'EXECUTED', '7:578d0b92077eaf2ab95ad0ec087aa903', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2023-01-30 04:54:31.979699', 88, 'EXECUTED', '7:c95abe90d962c57a09ecaee57972835d', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-30 04:54:31.99035', 89, 'EXECUTED', '7:f1313bcc2994a5c4dc1062ed6d8282d3', 'addColumn tableName=REALM; customChange', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-30 04:54:32.018462', 90, 'EXECUTED', '7:90d763b52eaffebefbcbde55f269508b', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-30 04:54:32.044294', 91, 'EXECUTED', '7:d554f0cb92b764470dccfa5e0014a7dd', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-30 04:54:32.058952', 92, 'EXECUTED', '7:73193e3ab3c35cf0f37ccea3bf783764', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-30 04:54:32.061617', 93, 'MARK_RAN', '7:90a1e74f92e9cbaa0c5eab80b8a037f3', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-30 04:54:32.080544', 94, 'EXECUTED', '7:5b9248f29cd047c200083cc6d8388b16', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-30 04:54:32.083332', 95, 'MARK_RAN', '7:64db59e44c374f13955489e8990d17a1', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-30 04:54:32.090874', 96, 'EXECUTED', '7:329a578cdb43262fff975f0a7f6cda60', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-30 04:54:32.150914', 97, 'EXECUTED', '7:fae0de241ac0fd0bbc2b380b85e4f567', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-30 04:54:32.153522', 98, 'MARK_RAN', '7:075d54e9180f49bb0c64ca4218936e81', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-30 04:54:32.171356', 99, 'MARK_RAN', '7:06499836520f4f6b3d05e35a59324910', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-30 04:54:32.195116', 100, 'EXECUTED', '7:fad08e83c77d0171ec166bc9bc5d390a', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-30 04:54:32.197611', 101, 'MARK_RAN', '7:3d2b23076e59c6f70bae703aa01be35b', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-30 04:54:32.221234', 102, 'EXECUTED', '7:1a7f28ff8d9e53aeb879d76ea3d9341a', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-30 04:54:32.226563', 103, 'EXECUTED', '7:2fd554456fed4a82c698c555c5b751b6', 'customChange', '', NULL, '3.5.4', NULL, NULL, '5054466951');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2023-01-30 04:54:32.234365', 104, 'EXECUTED', '7:b06356d66c2790ecc2ae54ba0458397a', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '3.5.4', NULL, NULL, '5054466951');


--
-- TOC entry 4140 (class 0 OID 16385)
-- Dependencies: 214
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);
INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1000, false, NULL, NULL);
INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1001, false, NULL, NULL);


--
-- TOC entry 4224 (class 0 OID 17783)
-- Dependencies: 298
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', 'f94d82e0-6443-4b99-9aba-a59d70b06323', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '28bdfcf3-7bff-4d63-8aa6-f442ea2c5f84', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '60c834b4-8046-4f6c-8dbb-b0ef6430bc94', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '7b4c52f1-bd0e-40ec-a332-50c0adcd2397', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', 'af432425-20ca-4f21-8a70-23e7c92b0fa8', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '9f6ecb03-57d0-4f8f-a350-ff5d15de02bc', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', 'd7625354-2a00-4094-88d0-2a006811bcf1', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '99c5f2b8-af85-416d-a519-7c5f39ba32b9', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '298223df-31a6-4919-bc10-cc95f1559dce', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CRG', '9cb30c0b-befb-4fe9-b066-641ec06b7880', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CRG', '48196b94-8301-499d-8a73-03f39d54d2c0', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CRG', '57f20769-ab20-46af-80e7-101f491f9813', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CRG', 'da6c7dc4-a51d-4826-bf03-88a91eaf2a3d', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CRG', '0ceb7c67-ee89-4ab0-9189-becbbb36acc7', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CRG', 'e7527488-ca33-4530-a690-86da328fa389', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CRG', 'eb72d3a6-b376-4389-9469-c3eacc0500f6', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CRG', '446066a7-1a98-4e6f-af46-75b13c6982d4', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CRG', '9b8b4f1f-3b91-49d4-aa1f-d3694a55f08c', false);


--
-- TOC entry 4147 (class 0 OID 16425)
-- Dependencies: 221
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4212 (class 0 OID 17482)
-- Dependencies: 286
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4213 (class 0 OID 17487)
-- Dependencies: 287
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4226 (class 0 OID 17809)
-- Dependencies: 300
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4214 (class 0 OID 17496)
-- Dependencies: 288
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4215 (class 0 OID 17505)
-- Dependencies: 289
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4216 (class 0 OID 17508)
-- Dependencies: 290
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4217 (class 0 OID 17514)
-- Dependencies: 291
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4170 (class 0 OID 16802)
-- Dependencies: 244
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4220 (class 0 OID 17579)
-- Dependencies: 294
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4196 (class 0 OID 17204)
-- Dependencies: 270
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4195 (class 0 OID 17201)
-- Dependencies: 269
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('abe5f2c0-788b-46bc-aaf8-3109ad83ff2a', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('bf54e3d7-3bfd-4eb5-8b98-f95400e488f4', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('8a4e694a-f869-4752-8371-a6be8f1f6677', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('2e79de55-b59a-4409-9cb7-330ddd7614a8', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('e37c9b71-0f80-4777-ba1a-ce2426f12998', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('5eb82123-9918-4480-adcf-2c6677678c0b', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('017dcbbc-24ed-41d7-a52f-af655fb492f4', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('8092d763-42a5-42e6-8358-c72b1bf46738', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('93ef9e8b-0510-4f74-b4b1-10f166757419', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('a44a56b0-6865-44b4-81e0-72cf41fbb163', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('856881a1-8944-47fe-9afe-3fcce43c603f', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('8fdb94af-1a19-497c-b194-788b8dd3468d', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('722e35ec-c7ad-45d8-8904-e8938f28c4d0', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('977b0882-b274-403c-bf6b-af68c45d3267', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('999a5e0d-ea18-446f-a6d4-e8e191a62dca', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('33b2407a-7e56-40eb-9c93-4a1f2a693b53', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('a0292efd-4276-465c-a803-279a05c2b0d3', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('9d968aae-c989-4a10-acca-b9e08020dc1f', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');
INSERT INTO public.group_role_mapping (role_id, group_id) VALUES ('971f077e-86db-4dbf-966d-76254fe9bbfa', 'ec98ba40-946f-48a5-bc1b-a7585dfec9b7');


--
-- TOC entry 4171 (class 0 OID 16807)
-- Dependencies: 245
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4172 (class 0 OID 16816)
-- Dependencies: 246
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4177 (class 0 OID 16920)
-- Dependencies: 251
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4178 (class 0 OID 16925)
-- Dependencies: 252
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4194 (class 0 OID 17198)
-- Dependencies: 268
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.keycloak_group (id, name, parent_group, realm_id) VALUES ('ec98ba40-946f-48a5-bc1b-a7585dfec9b7', 'crg-admins-group', ' ', 'CRG');


--
-- TOC entry 4148 (class 0 OID 16433)
-- Dependencies: 222
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('76c71245-4328-4c0e-8efc-0ba93dd9cae5', 'master', false, '${role_default-roles}', 'default-roles-master', 'master', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', 'master', false, '${role_admin}', 'admin', 'master', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8444d31d-84bb-418b-9a0a-b49a26b9b70f', 'master', false, '${role_create-realm}', 'create-realm', 'master', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('cbf8b5f0-2627-4f21-92af-5d6aae50e5d1', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_create-client}', 'create-client', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('13360936-f42e-4085-a33f-425fc4423147', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_view-realm}', 'view-realm', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('dd830b3d-902f-49ce-a881-f1c25544e80e', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_view-users}', 'view-users', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b3ccf2ba-24a1-48ef-bd3a-b442e654a4fc', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_view-clients}', 'view-clients', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('2e4ab954-17d2-4882-88ee-6ba70321daf0', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_view-events}', 'view-events', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('ee5c4a8b-afc9-43ae-a172-b56b5462b8fa', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('580aa5c0-f96b-4cdc-9d1c-4b34009c5ae2', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_view-authorization}', 'view-authorization', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b64595a5-66ad-4677-9eff-861fecc64f19', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_manage-realm}', 'manage-realm', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('14c011d7-a582-44ea-b44e-784f9783fcc6', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_manage-users}', 'manage-users', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('70acc01d-f669-473d-b314-b46488074750', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_manage-clients}', 'manage-clients', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8a048125-5764-4d1d-a892-cbfa6c7bed66', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_manage-events}', 'manage-events', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f91c0a14-0b6c-4c21-bc6b-ce9c13e497d7', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('dc58c01f-290c-4c3f-96b9-7af787f9aa6f', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_manage-authorization}', 'manage-authorization', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c5981d9e-6446-43cd-a158-8e98bef5f8ab', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_query-users}', 'query-users', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('27285100-afd2-42a2-a2c0-671aaf5ae66d', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_query-clients}', 'query-clients', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9f746ee4-dd4d-4b35-9ee2-47979ef8eeb4', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_query-realms}', 'query-realms', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c8555230-f58f-4a75-a37e-c603535f3ada', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_query-groups}', 'query-groups', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8d9b8596-c58b-471b-b3cb-cbca6d928fbb', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', true, '${role_view-profile}', 'view-profile', 'master', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f03b89ac-8890-49f4-88b4-e0ca69298469', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', true, '${role_manage-account}', 'manage-account', 'master', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d4f55ce7-3221-4719-954a-de94b334044a', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', true, '${role_manage-account-links}', 'manage-account-links', 'master', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('31f4fd85-c8f1-4393-a7f0-997470959d56', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', true, '${role_view-applications}', 'view-applications', 'master', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('bd929c6f-ead4-49ee-b081-31c10cf8cb08', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', true, '${role_view-consent}', 'view-consent', 'master', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('99262a04-9b09-469a-9354-1eb1a267282b', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', true, '${role_manage-consent}', 'manage-consent', 'master', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d32637c0-5393-4a32-85a6-ff777c307091', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', true, '${role_delete-account}', 'delete-account', 'master', '7d0e8031-37aa-4cf7-ab11-3eb40df011af', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('19836ee6-cc85-46df-a28a-e34da506f5d2', '38a33770-f0a0-4b63-ace9-715ae4e4caaf', true, '${role_read-token}', 'read-token', 'master', '38a33770-f0a0-4b63-ace9-715ae4e4caaf', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('27af635b-1cb8-4a37-a847-b50a44d573af', '59533569-54f7-4686-b7ba-7346241d1be6', true, '${role_impersonation}', 'impersonation', 'master', '59533569-54f7-4686-b7ba-7346241d1be6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('125582c9-7be4-424d-b1d3-3e9767809d37', 'master', false, '${role_offline-access}', 'offline_access', 'master', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0ef31d4e-787c-431e-a4f9-1ff99a9dc215', 'master', false, '${role_uma_authorization}', 'uma_authorization', 'master', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('59a0fcbc-58e9-49d9-a13b-bad975f4ae0c', 'CRG', false, '${role_default-roles}', 'default-roles-crg', 'CRG', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('1444d754-6055-47de-b7af-de2ca30a7536', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_create-client}', 'create-client', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0dbb8d9e-9d98-4808-9a46-c9cc75cc8969', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_view-realm}', 'view-realm', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9e77084c-2977-46a8-bf97-b0f9dd0b618c', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_view-users}', 'view-users', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('bd8bdfc9-b33c-4ce8-aceb-45d5a1a102e4', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_view-clients}', 'view-clients', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('ce57c72c-892a-42e1-ae2d-aa8d86ad003e', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_view-events}', 'view-events', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d91e26b4-3955-47a2-b89c-92a4639ba6af', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b123360b-b6b2-4e5e-8a24-c3a5ac0fdb56', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_view-authorization}', 'view-authorization', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('833bbc53-d5dc-4775-b0eb-3b5f56f53ddb', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_manage-realm}', 'manage-realm', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0edfb085-e9de-4cfc-ab4c-f3c834518337', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_manage-users}', 'manage-users', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9dd86adc-f341-4205-9707-536e026e02e5', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_manage-clients}', 'manage-clients', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('1678aa44-a238-4de5-8e4c-79ad471d8991', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_manage-events}', 'manage-events', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('71080794-64c2-4ccf-a22c-a5b7473bbc7a', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('47940d42-7ca8-4ed1-8407-40cd20c42599', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_manage-authorization}', 'manage-authorization', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('43f5c2c2-d25b-42b3-bdd9-6ed4e906637d', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_query-users}', 'query-users', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('521d2448-460d-4fb2-8a59-4958b9af57a7', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_query-clients}', 'query-clients', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0de404e7-9322-460a-a1bb-75c38b0ff249', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_query-realms}', 'query-realms', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('91fde41e-a650-4238-b085-0dfac2cbc06f', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_query-groups}', 'query-groups', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_realm-admin}', 'realm-admin', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('bf54e3d7-3bfd-4eb5-8b98-f95400e488f4', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_create-client}', 'create-client', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9d968aae-c989-4a10-acca-b9e08020dc1f', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_view-realm}', 'view-realm', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('971f077e-86db-4dbf-966d-76254fe9bbfa', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_view-users}', 'view-users', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('999a5e0d-ea18-446f-a6d4-e8e191a62dca', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_view-clients}', 'view-clients', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('33b2407a-7e56-40eb-9c93-4a1f2a693b53', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_view-events}', 'view-events', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a0292efd-4276-465c-a803-279a05c2b0d3', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_view-identity-providers}', 'view-identity-providers', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('977b0882-b274-403c-bf6b-af68c45d3267', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_view-authorization}', 'view-authorization', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8092d763-42a5-42e6-8358-c72b1bf46738', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_manage-realm}', 'manage-realm', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('93ef9e8b-0510-4f74-b4b1-10f166757419', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_manage-users}', 'manage-users', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e37c9b71-0f80-4777-ba1a-ce2426f12998', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_manage-clients}', 'manage-clients', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('5eb82123-9918-4480-adcf-2c6677678c0b', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_manage-events}', 'manage-events', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('017dcbbc-24ed-41d7-a52f-af655fb492f4', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('2e79de55-b59a-4409-9cb7-330ddd7614a8', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_manage-authorization}', 'manage-authorization', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('722e35ec-c7ad-45d8-8904-e8938f28c4d0', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_query-users}', 'query-users', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a44a56b0-6865-44b4-81e0-72cf41fbb163', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_query-clients}', 'query-clients', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8fdb94af-1a19-497c-b194-788b8dd3468d', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_query-realms}', 'query-realms', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('856881a1-8944-47fe-9afe-3fcce43c603f', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_query-groups}', 'query-groups', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('fb5c7018-fdcb-41b3-b110-ae36285905be', 'f6b41486-3352-4580-af22-418607631beb', true, '${role_view-profile}', 'view-profile', 'CRG', 'f6b41486-3352-4580-af22-418607631beb', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('1408df24-7005-4e50-8e3b-9bfe74d0cccf', 'f6b41486-3352-4580-af22-418607631beb', true, '${role_manage-account}', 'manage-account', 'CRG', 'f6b41486-3352-4580-af22-418607631beb', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c1a9f03b-3459-459e-b16e-c568c505e627', 'f6b41486-3352-4580-af22-418607631beb', true, '${role_manage-account-links}', 'manage-account-links', 'CRG', 'f6b41486-3352-4580-af22-418607631beb', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e9718294-90c3-4642-b487-bf68c23a7083', 'f6b41486-3352-4580-af22-418607631beb', true, '${role_view-applications}', 'view-applications', 'CRG', 'f6b41486-3352-4580-af22-418607631beb', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9ff8d5cc-a5d5-4d34-9b05-4c843b231dd2', 'f6b41486-3352-4580-af22-418607631beb', true, '${role_view-consent}', 'view-consent', 'CRG', 'f6b41486-3352-4580-af22-418607631beb', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('38d5c2fa-1a94-4a44-a52f-7244eabfdb59', 'f6b41486-3352-4580-af22-418607631beb', true, '${role_manage-consent}', 'manage-consent', 'CRG', 'f6b41486-3352-4580-af22-418607631beb', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e4cc9499-3197-4d54-8e6f-e579fc27e558', 'f6b41486-3352-4580-af22-418607631beb', true, '${role_delete-account}', 'delete-account', 'CRG', 'f6b41486-3352-4580-af22-418607631beb', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('41d32941-4bea-4b35-9ad7-f5391660f52a', '88464ba2-f74b-407a-ac8a-38d83e763db8', true, '${role_impersonation}', 'impersonation', 'master', '88464ba2-f74b-407a-ac8a-38d83e763db8', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8a4e694a-f869-4752-8371-a6be8f1f6677', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', true, '${role_impersonation}', 'impersonation', 'CRG', '01d43d55-655d-4bfa-8c96-6abf7a9be60c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('645a578a-6564-4ee2-bc4a-1ef728c38226', '7741f182-daa1-40f4-a3d0-c4b1706b5884', true, '${role_read-token}', 'read-token', 'CRG', '7741f182-daa1-40f4-a3d0-c4b1706b5884', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('3b828ec7-2243-425d-8605-60cd2e4850e9', 'CRG', false, '${role_offline-access}', 'offline_access', 'CRG', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('530ab842-3c42-4db1-9eb2-80fb0bba79f5', 'CRG', false, '${role_uma_authorization}', 'uma_authorization', 'CRG', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('78c21f6b-d765-4689-a7a1-ae3ec65d1b98', 'CRG', false, 'A user of the Character Relations Graph application', 'crg-user', 'CRG', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('abe5f2c0-788b-46bc-aaf8-3109ad83ff2a', 'CRG', false, 'An administrator for the Characters Relations Graph resources', 'crg-admin', 'CRG', NULL, NULL);


--
-- TOC entry 4176 (class 0 OID 16917)
-- Dependencies: 250
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.migration_model (id, version, update_time) VALUES ('zmpnb', '16.1.0', 1675054475);


--
-- TOC entry 4193 (class 0 OID 17189)
-- Dependencies: 267
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4192 (class 0 OID 17184)
-- Dependencies: 266
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4206 (class 0 OID 17405)
-- Dependencies: 280
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4168 (class 0 OID 16791)
-- Dependencies: 242
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('6cc2b016-7298-4190-a907-29ef6a712e34', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '2875f6df-1a0e-463b-a362-593f26e8fa79', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('50d332a5-55f4-4eeb-9c1c-77e148cd2986', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', 'abac7ebf-4c69-4275-bb77-760a19933344', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('fbc9d511-2cfe-4855-b14c-05bb783129b0', 'role list', 'saml', 'saml-role-list-mapper', NULL, '28bdfcf3-7bff-4d63-8aa6-f442ea2c5f84');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('2ef8fba5-7c5b-46c7-a0f7-6f05a8aa0a5c', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('900a3551-86b3-4b20-ab96-1715287ba2bb', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('9554066d-c627-4c7d-8bdf-7000cf8e82d7', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('55cbad48-1934-4a14-968b-ed3d72bcd64b', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('061593ae-11fe-4dea-a59b-66465730098e', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('455c697d-2d65-4348-ae43-68982f866bc7', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('2f622bbb-7eb1-4ccd-b635-c2ff743b6ab8', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('09d62baa-3311-4cc0-9b27-6cb577c02feb', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('bcf94d3a-0493-44e2-a126-6fb8f3d79ebf', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('17a53444-185a-447a-946d-b84628728bf3', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('6c019cdf-2f7e-4659-86f2-aa8d58ac4212', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('261afadf-f281-4180-ba89-a6edc166697d', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('77640da8-f655-490f-a7cc-1b66de65f5af', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('a2cc39ff-7cf2-46e1-93a2-75cd0a6451f2', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '60c834b4-8046-4f6c-8dbb-b0ef6430bc94');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('57d7d62c-da0c-4606-b153-0f56b730e10f', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '7b4c52f1-bd0e-40ec-a332-50c0adcd2397');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('2d0fb198-4dc2-485a-891b-eaa15880be15', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '7b4c52f1-bd0e-40ec-a332-50c0adcd2397');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('9b971de5-1ac5-49b8-974f-ff1a4fc1e68a', 'address', 'openid-connect', 'oidc-address-mapper', NULL, 'af432425-20ca-4f21-8a70-23e7c92b0fa8');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('d3f0ab3f-7074-44e4-9e65-5634983b49a5', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '9f6ecb03-57d0-4f8f-a350-ff5d15de02bc');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('96cf3849-5d73-4dba-a06c-3ea0251b6edb', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '9f6ecb03-57d0-4f8f-a350-ff5d15de02bc');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('89e0db65-b71e-46df-8377-c19437172a11', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'd7625354-2a00-4094-88d0-2a006811bcf1');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b05ea31f-793a-41f8-b80e-cef5c4aa5d89', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, 'd7625354-2a00-4094-88d0-2a006811bcf1');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3b7f11ba-ffa2-44fd-9577-0fd60d5c9910', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, 'd7625354-2a00-4094-88d0-2a006811bcf1');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b0b2dee1-e3d5-4137-8e91-b8f99c9df526', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '99c5f2b8-af85-416d-a519-7c5f39ba32b9');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f8b8d377-fffb-4948-8744-38bd1fac6396', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '298223df-31a6-4919-bc10-cc95f1559dce');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('22d27da7-9485-48d8-b723-8c6cf9aea045', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '298223df-31a6-4919-bc10-cc95f1559dce');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('1ec7cfe8-afe5-43b6-a811-438c71751a59', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '596d2e5a-b4eb-4b95-b725-dc582921b997', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('fdc53fe3-a4e3-42b2-8863-1527f356dce6', 'role list', 'saml', 'saml-role-list-mapper', NULL, '48196b94-8301-499d-8a73-03f39d54d2c0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('691c42eb-7262-4ce0-ba34-efca211e6b07', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('9bec3aca-250b-49b9-a734-adcaf1f77ae9', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('77a9683b-54b8-474c-9910-6c20a963f594', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('81f8b858-f9c3-4afd-bf4f-b6423f3c8d03', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('836123f4-90e4-419a-abe5-93870b0796f2', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('fe772fb0-1aab-43b5-bcbc-ce03760c968f', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('6b7776a7-8c90-4bdc-9f8a-c81a9dc3bf44', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3061d1c3-bc8e-4550-ab87-cbec6b5afde8', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('c29f1779-c6d9-4f90-bf7c-437da5e5c0cd', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('d5ca7562-84d8-43e3-b3e2-b0bc862259c0', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f7fa30a8-3da4-465f-bedc-b5bea0b9565c', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('6ba8c66b-b5cf-44e4-907f-248403ca46fd', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('c7b64837-ca63-44d0-8c57-2f427f5ae9aa', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('65db2e16-f41d-40de-b590-4571d9b3efa3', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '57f20769-ab20-46af-80e7-101f491f9813');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('850935c8-e384-4c78-8c2c-e8af06f0417b', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'da6c7dc4-a51d-4826-bf03-88a91eaf2a3d');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('122ed6b9-5d8f-4ec8-945c-aa446c1ad7a7', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'da6c7dc4-a51d-4826-bf03-88a91eaf2a3d');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('c22e8a87-696b-4d2e-868b-1fd3e55e6f2a', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '0ceb7c67-ee89-4ab0-9189-becbbb36acc7');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('22bbf710-f1ec-44cf-9285-842bdeb888e2', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'e7527488-ca33-4530-a690-86da328fa389');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('7f03e446-1c60-425d-823e-128924b22850', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'e7527488-ca33-4530-a690-86da328fa389');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('4f3dd50b-b50c-4483-a54f-c27652a78f54', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'eb72d3a6-b376-4389-9469-c3eacc0500f6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b93801fe-72fa-4d46-a6b8-906e2b448070', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, 'eb72d3a6-b376-4389-9469-c3eacc0500f6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('20d0530f-c9e7-41fb-8303-00c7b1260c2e', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, 'eb72d3a6-b376-4389-9469-c3eacc0500f6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('cea4122a-b3ac-4196-87d6-203ce11ddf36', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '446066a7-1a98-4e6f-af46-75b13c6982d4');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('80349295-914b-4964-be2b-d6dd8f60a7ab', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '9b8b4f1f-3b91-49d4-aa1f-d3694a55f08c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('a495f70a-0b88-4146-a5f6-63a4ab67b2ba', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '9b8b4f1f-3b91-49d4-aa1f-d3694a55f08c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('5bbed123-e5e5-4f21-a03b-bc60182f6293', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '7a249ae3-dfb6-460a-b488-f44ef5d37554', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('25fc948a-6a2b-4ab1-8e18-9dd71121159a', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '29692d4c-d25b-4cca-9f60-b1b52233b532', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('7af71785-1a32-4ce2-8d0b-153fb54cf84d', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '29692d4c-d25b-4cca-9f60-b1b52233b532', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('793c4824-1ef6-44e3-b53f-6a282e142917', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '29692d4c-d25b-4cca-9f60-b1b52233b532', NULL);


--
-- TOC entry 4169 (class 0 OID 16797)
-- Dependencies: 243
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('50d332a5-55f4-4eeb-9c1c-77e148cd2986', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('50d332a5-55f4-4eeb-9c1c-77e148cd2986', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('50d332a5-55f4-4eeb-9c1c-77e148cd2986', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('50d332a5-55f4-4eeb-9c1c-77e148cd2986', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('50d332a5-55f4-4eeb-9c1c-77e148cd2986', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('50d332a5-55f4-4eeb-9c1c-77e148cd2986', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fbc9d511-2cfe-4855-b14c-05bb783129b0', 'false', 'single');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fbc9d511-2cfe-4855-b14c-05bb783129b0', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fbc9d511-2cfe-4855-b14c-05bb783129b0', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2ef8fba5-7c5b-46c7-a0f7-6f05a8aa0a5c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2ef8fba5-7c5b-46c7-a0f7-6f05a8aa0a5c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2ef8fba5-7c5b-46c7-a0f7-6f05a8aa0a5c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('900a3551-86b3-4b20-ab96-1715287ba2bb', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('900a3551-86b3-4b20-ab96-1715287ba2bb', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('900a3551-86b3-4b20-ab96-1715287ba2bb', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('900a3551-86b3-4b20-ab96-1715287ba2bb', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('900a3551-86b3-4b20-ab96-1715287ba2bb', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('900a3551-86b3-4b20-ab96-1715287ba2bb', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9554066d-c627-4c7d-8bdf-7000cf8e82d7', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9554066d-c627-4c7d-8bdf-7000cf8e82d7', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9554066d-c627-4c7d-8bdf-7000cf8e82d7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9554066d-c627-4c7d-8bdf-7000cf8e82d7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9554066d-c627-4c7d-8bdf-7000cf8e82d7', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9554066d-c627-4c7d-8bdf-7000cf8e82d7', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('55cbad48-1934-4a14-968b-ed3d72bcd64b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('55cbad48-1934-4a14-968b-ed3d72bcd64b', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('55cbad48-1934-4a14-968b-ed3d72bcd64b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('55cbad48-1934-4a14-968b-ed3d72bcd64b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('55cbad48-1934-4a14-968b-ed3d72bcd64b', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('55cbad48-1934-4a14-968b-ed3d72bcd64b', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('061593ae-11fe-4dea-a59b-66465730098e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('061593ae-11fe-4dea-a59b-66465730098e', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('061593ae-11fe-4dea-a59b-66465730098e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('061593ae-11fe-4dea-a59b-66465730098e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('061593ae-11fe-4dea-a59b-66465730098e', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('061593ae-11fe-4dea-a59b-66465730098e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('455c697d-2d65-4348-ae43-68982f866bc7', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('455c697d-2d65-4348-ae43-68982f866bc7', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('455c697d-2d65-4348-ae43-68982f866bc7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('455c697d-2d65-4348-ae43-68982f866bc7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('455c697d-2d65-4348-ae43-68982f866bc7', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('455c697d-2d65-4348-ae43-68982f866bc7', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f622bbb-7eb1-4ccd-b635-c2ff743b6ab8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f622bbb-7eb1-4ccd-b635-c2ff743b6ab8', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f622bbb-7eb1-4ccd-b635-c2ff743b6ab8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f622bbb-7eb1-4ccd-b635-c2ff743b6ab8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f622bbb-7eb1-4ccd-b635-c2ff743b6ab8', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f622bbb-7eb1-4ccd-b635-c2ff743b6ab8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('09d62baa-3311-4cc0-9b27-6cb577c02feb', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('09d62baa-3311-4cc0-9b27-6cb577c02feb', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('09d62baa-3311-4cc0-9b27-6cb577c02feb', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('09d62baa-3311-4cc0-9b27-6cb577c02feb', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('09d62baa-3311-4cc0-9b27-6cb577c02feb', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('09d62baa-3311-4cc0-9b27-6cb577c02feb', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bcf94d3a-0493-44e2-a126-6fb8f3d79ebf', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bcf94d3a-0493-44e2-a126-6fb8f3d79ebf', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bcf94d3a-0493-44e2-a126-6fb8f3d79ebf', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bcf94d3a-0493-44e2-a126-6fb8f3d79ebf', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bcf94d3a-0493-44e2-a126-6fb8f3d79ebf', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bcf94d3a-0493-44e2-a126-6fb8f3d79ebf', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('17a53444-185a-447a-946d-b84628728bf3', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('17a53444-185a-447a-946d-b84628728bf3', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('17a53444-185a-447a-946d-b84628728bf3', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('17a53444-185a-447a-946d-b84628728bf3', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('17a53444-185a-447a-946d-b84628728bf3', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('17a53444-185a-447a-946d-b84628728bf3', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6c019cdf-2f7e-4659-86f2-aa8d58ac4212', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6c019cdf-2f7e-4659-86f2-aa8d58ac4212', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6c019cdf-2f7e-4659-86f2-aa8d58ac4212', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6c019cdf-2f7e-4659-86f2-aa8d58ac4212', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6c019cdf-2f7e-4659-86f2-aa8d58ac4212', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6c019cdf-2f7e-4659-86f2-aa8d58ac4212', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('261afadf-f281-4180-ba89-a6edc166697d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('261afadf-f281-4180-ba89-a6edc166697d', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('261afadf-f281-4180-ba89-a6edc166697d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('261afadf-f281-4180-ba89-a6edc166697d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('261afadf-f281-4180-ba89-a6edc166697d', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('261afadf-f281-4180-ba89-a6edc166697d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77640da8-f655-490f-a7cc-1b66de65f5af', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77640da8-f655-490f-a7cc-1b66de65f5af', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77640da8-f655-490f-a7cc-1b66de65f5af', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77640da8-f655-490f-a7cc-1b66de65f5af', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77640da8-f655-490f-a7cc-1b66de65f5af', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77640da8-f655-490f-a7cc-1b66de65f5af', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a2cc39ff-7cf2-46e1-93a2-75cd0a6451f2', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a2cc39ff-7cf2-46e1-93a2-75cd0a6451f2', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a2cc39ff-7cf2-46e1-93a2-75cd0a6451f2', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a2cc39ff-7cf2-46e1-93a2-75cd0a6451f2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a2cc39ff-7cf2-46e1-93a2-75cd0a6451f2', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a2cc39ff-7cf2-46e1-93a2-75cd0a6451f2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('57d7d62c-da0c-4606-b153-0f56b730e10f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('57d7d62c-da0c-4606-b153-0f56b730e10f', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('57d7d62c-da0c-4606-b153-0f56b730e10f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('57d7d62c-da0c-4606-b153-0f56b730e10f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('57d7d62c-da0c-4606-b153-0f56b730e10f', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('57d7d62c-da0c-4606-b153-0f56b730e10f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2d0fb198-4dc2-485a-891b-eaa15880be15', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2d0fb198-4dc2-485a-891b-eaa15880be15', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2d0fb198-4dc2-485a-891b-eaa15880be15', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2d0fb198-4dc2-485a-891b-eaa15880be15', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2d0fb198-4dc2-485a-891b-eaa15880be15', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2d0fb198-4dc2-485a-891b-eaa15880be15', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9b971de5-1ac5-49b8-974f-ff1a4fc1e68a', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9b971de5-1ac5-49b8-974f-ff1a4fc1e68a', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9b971de5-1ac5-49b8-974f-ff1a4fc1e68a', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9b971de5-1ac5-49b8-974f-ff1a4fc1e68a', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9b971de5-1ac5-49b8-974f-ff1a4fc1e68a', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9b971de5-1ac5-49b8-974f-ff1a4fc1e68a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9b971de5-1ac5-49b8-974f-ff1a4fc1e68a', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9b971de5-1ac5-49b8-974f-ff1a4fc1e68a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9b971de5-1ac5-49b8-974f-ff1a4fc1e68a', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d3f0ab3f-7074-44e4-9e65-5634983b49a5', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d3f0ab3f-7074-44e4-9e65-5634983b49a5', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d3f0ab3f-7074-44e4-9e65-5634983b49a5', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d3f0ab3f-7074-44e4-9e65-5634983b49a5', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d3f0ab3f-7074-44e4-9e65-5634983b49a5', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d3f0ab3f-7074-44e4-9e65-5634983b49a5', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('96cf3849-5d73-4dba-a06c-3ea0251b6edb', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('96cf3849-5d73-4dba-a06c-3ea0251b6edb', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('96cf3849-5d73-4dba-a06c-3ea0251b6edb', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('96cf3849-5d73-4dba-a06c-3ea0251b6edb', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('96cf3849-5d73-4dba-a06c-3ea0251b6edb', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('96cf3849-5d73-4dba-a06c-3ea0251b6edb', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('89e0db65-b71e-46df-8377-c19437172a11', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('89e0db65-b71e-46df-8377-c19437172a11', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('89e0db65-b71e-46df-8377-c19437172a11', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('89e0db65-b71e-46df-8377-c19437172a11', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('89e0db65-b71e-46df-8377-c19437172a11', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b05ea31f-793a-41f8-b80e-cef5c4aa5d89', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b05ea31f-793a-41f8-b80e-cef5c4aa5d89', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b05ea31f-793a-41f8-b80e-cef5c4aa5d89', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b05ea31f-793a-41f8-b80e-cef5c4aa5d89', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b05ea31f-793a-41f8-b80e-cef5c4aa5d89', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8b8d377-fffb-4948-8744-38bd1fac6396', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8b8d377-fffb-4948-8744-38bd1fac6396', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8b8d377-fffb-4948-8744-38bd1fac6396', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8b8d377-fffb-4948-8744-38bd1fac6396', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8b8d377-fffb-4948-8744-38bd1fac6396', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8b8d377-fffb-4948-8744-38bd1fac6396', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22d27da7-9485-48d8-b723-8c6cf9aea045', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22d27da7-9485-48d8-b723-8c6cf9aea045', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22d27da7-9485-48d8-b723-8c6cf9aea045', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22d27da7-9485-48d8-b723-8c6cf9aea045', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22d27da7-9485-48d8-b723-8c6cf9aea045', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22d27da7-9485-48d8-b723-8c6cf9aea045', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fdc53fe3-a4e3-42b2-8863-1527f356dce6', 'false', 'single');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fdc53fe3-a4e3-42b2-8863-1527f356dce6', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fdc53fe3-a4e3-42b2-8863-1527f356dce6', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('691c42eb-7262-4ce0-ba34-efca211e6b07', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('691c42eb-7262-4ce0-ba34-efca211e6b07', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('691c42eb-7262-4ce0-ba34-efca211e6b07', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9bec3aca-250b-49b9-a734-adcaf1f77ae9', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9bec3aca-250b-49b9-a734-adcaf1f77ae9', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9bec3aca-250b-49b9-a734-adcaf1f77ae9', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9bec3aca-250b-49b9-a734-adcaf1f77ae9', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9bec3aca-250b-49b9-a734-adcaf1f77ae9', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9bec3aca-250b-49b9-a734-adcaf1f77ae9', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77a9683b-54b8-474c-9910-6c20a963f594', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77a9683b-54b8-474c-9910-6c20a963f594', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77a9683b-54b8-474c-9910-6c20a963f594', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77a9683b-54b8-474c-9910-6c20a963f594', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77a9683b-54b8-474c-9910-6c20a963f594', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77a9683b-54b8-474c-9910-6c20a963f594', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('81f8b858-f9c3-4afd-bf4f-b6423f3c8d03', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('81f8b858-f9c3-4afd-bf4f-b6423f3c8d03', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('81f8b858-f9c3-4afd-bf4f-b6423f3c8d03', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('81f8b858-f9c3-4afd-bf4f-b6423f3c8d03', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('81f8b858-f9c3-4afd-bf4f-b6423f3c8d03', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('81f8b858-f9c3-4afd-bf4f-b6423f3c8d03', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('836123f4-90e4-419a-abe5-93870b0796f2', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('836123f4-90e4-419a-abe5-93870b0796f2', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('836123f4-90e4-419a-abe5-93870b0796f2', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('836123f4-90e4-419a-abe5-93870b0796f2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('836123f4-90e4-419a-abe5-93870b0796f2', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('836123f4-90e4-419a-abe5-93870b0796f2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fe772fb0-1aab-43b5-bcbc-ce03760c968f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fe772fb0-1aab-43b5-bcbc-ce03760c968f', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fe772fb0-1aab-43b5-bcbc-ce03760c968f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fe772fb0-1aab-43b5-bcbc-ce03760c968f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fe772fb0-1aab-43b5-bcbc-ce03760c968f', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fe772fb0-1aab-43b5-bcbc-ce03760c968f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6b7776a7-8c90-4bdc-9f8a-c81a9dc3bf44', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6b7776a7-8c90-4bdc-9f8a-c81a9dc3bf44', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6b7776a7-8c90-4bdc-9f8a-c81a9dc3bf44', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6b7776a7-8c90-4bdc-9f8a-c81a9dc3bf44', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6b7776a7-8c90-4bdc-9f8a-c81a9dc3bf44', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6b7776a7-8c90-4bdc-9f8a-c81a9dc3bf44', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3061d1c3-bc8e-4550-ab87-cbec6b5afde8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3061d1c3-bc8e-4550-ab87-cbec6b5afde8', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3061d1c3-bc8e-4550-ab87-cbec6b5afde8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3061d1c3-bc8e-4550-ab87-cbec6b5afde8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3061d1c3-bc8e-4550-ab87-cbec6b5afde8', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3061d1c3-bc8e-4550-ab87-cbec6b5afde8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c29f1779-c6d9-4f90-bf7c-437da5e5c0cd', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c29f1779-c6d9-4f90-bf7c-437da5e5c0cd', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c29f1779-c6d9-4f90-bf7c-437da5e5c0cd', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c29f1779-c6d9-4f90-bf7c-437da5e5c0cd', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c29f1779-c6d9-4f90-bf7c-437da5e5c0cd', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c29f1779-c6d9-4f90-bf7c-437da5e5c0cd', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d5ca7562-84d8-43e3-b3e2-b0bc862259c0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d5ca7562-84d8-43e3-b3e2-b0bc862259c0', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d5ca7562-84d8-43e3-b3e2-b0bc862259c0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d5ca7562-84d8-43e3-b3e2-b0bc862259c0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d5ca7562-84d8-43e3-b3e2-b0bc862259c0', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d5ca7562-84d8-43e3-b3e2-b0bc862259c0', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f7fa30a8-3da4-465f-bedc-b5bea0b9565c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f7fa30a8-3da4-465f-bedc-b5bea0b9565c', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f7fa30a8-3da4-465f-bedc-b5bea0b9565c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f7fa30a8-3da4-465f-bedc-b5bea0b9565c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f7fa30a8-3da4-465f-bedc-b5bea0b9565c', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f7fa30a8-3da4-465f-bedc-b5bea0b9565c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6ba8c66b-b5cf-44e4-907f-248403ca46fd', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6ba8c66b-b5cf-44e4-907f-248403ca46fd', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6ba8c66b-b5cf-44e4-907f-248403ca46fd', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6ba8c66b-b5cf-44e4-907f-248403ca46fd', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6ba8c66b-b5cf-44e4-907f-248403ca46fd', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6ba8c66b-b5cf-44e4-907f-248403ca46fd', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c7b64837-ca63-44d0-8c57-2f427f5ae9aa', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c7b64837-ca63-44d0-8c57-2f427f5ae9aa', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c7b64837-ca63-44d0-8c57-2f427f5ae9aa', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c7b64837-ca63-44d0-8c57-2f427f5ae9aa', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c7b64837-ca63-44d0-8c57-2f427f5ae9aa', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c7b64837-ca63-44d0-8c57-2f427f5ae9aa', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('65db2e16-f41d-40de-b590-4571d9b3efa3', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('65db2e16-f41d-40de-b590-4571d9b3efa3', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('65db2e16-f41d-40de-b590-4571d9b3efa3', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('65db2e16-f41d-40de-b590-4571d9b3efa3', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('65db2e16-f41d-40de-b590-4571d9b3efa3', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('65db2e16-f41d-40de-b590-4571d9b3efa3', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('850935c8-e384-4c78-8c2c-e8af06f0417b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('850935c8-e384-4c78-8c2c-e8af06f0417b', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('850935c8-e384-4c78-8c2c-e8af06f0417b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('850935c8-e384-4c78-8c2c-e8af06f0417b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('850935c8-e384-4c78-8c2c-e8af06f0417b', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('850935c8-e384-4c78-8c2c-e8af06f0417b', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('122ed6b9-5d8f-4ec8-945c-aa446c1ad7a7', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('122ed6b9-5d8f-4ec8-945c-aa446c1ad7a7', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('122ed6b9-5d8f-4ec8-945c-aa446c1ad7a7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('122ed6b9-5d8f-4ec8-945c-aa446c1ad7a7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('122ed6b9-5d8f-4ec8-945c-aa446c1ad7a7', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('122ed6b9-5d8f-4ec8-945c-aa446c1ad7a7', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22e8a87-696b-4d2e-868b-1fd3e55e6f2a', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22e8a87-696b-4d2e-868b-1fd3e55e6f2a', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22e8a87-696b-4d2e-868b-1fd3e55e6f2a', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22e8a87-696b-4d2e-868b-1fd3e55e6f2a', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22e8a87-696b-4d2e-868b-1fd3e55e6f2a', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22e8a87-696b-4d2e-868b-1fd3e55e6f2a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22e8a87-696b-4d2e-868b-1fd3e55e6f2a', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22e8a87-696b-4d2e-868b-1fd3e55e6f2a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22e8a87-696b-4d2e-868b-1fd3e55e6f2a', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22bbf710-f1ec-44cf-9285-842bdeb888e2', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22bbf710-f1ec-44cf-9285-842bdeb888e2', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22bbf710-f1ec-44cf-9285-842bdeb888e2', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22bbf710-f1ec-44cf-9285-842bdeb888e2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22bbf710-f1ec-44cf-9285-842bdeb888e2', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('22bbf710-f1ec-44cf-9285-842bdeb888e2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7f03e446-1c60-425d-823e-128924b22850', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7f03e446-1c60-425d-823e-128924b22850', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7f03e446-1c60-425d-823e-128924b22850', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7f03e446-1c60-425d-823e-128924b22850', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7f03e446-1c60-425d-823e-128924b22850', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7f03e446-1c60-425d-823e-128924b22850', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4f3dd50b-b50c-4483-a54f-c27652a78f54', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4f3dd50b-b50c-4483-a54f-c27652a78f54', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4f3dd50b-b50c-4483-a54f-c27652a78f54', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4f3dd50b-b50c-4483-a54f-c27652a78f54', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4f3dd50b-b50c-4483-a54f-c27652a78f54', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b93801fe-72fa-4d46-a6b8-906e2b448070', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b93801fe-72fa-4d46-a6b8-906e2b448070', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b93801fe-72fa-4d46-a6b8-906e2b448070', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b93801fe-72fa-4d46-a6b8-906e2b448070', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b93801fe-72fa-4d46-a6b8-906e2b448070', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('80349295-914b-4964-be2b-d6dd8f60a7ab', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('80349295-914b-4964-be2b-d6dd8f60a7ab', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('80349295-914b-4964-be2b-d6dd8f60a7ab', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('80349295-914b-4964-be2b-d6dd8f60a7ab', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('80349295-914b-4964-be2b-d6dd8f60a7ab', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('80349295-914b-4964-be2b-d6dd8f60a7ab', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a495f70a-0b88-4146-a5f6-63a4ab67b2ba', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a495f70a-0b88-4146-a5f6-63a4ab67b2ba', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a495f70a-0b88-4146-a5f6-63a4ab67b2ba', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a495f70a-0b88-4146-a5f6-63a4ab67b2ba', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a495f70a-0b88-4146-a5f6-63a4ab67b2ba', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a495f70a-0b88-4146-a5f6-63a4ab67b2ba', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5bbed123-e5e5-4f21-a03b-bc60182f6293', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5bbed123-e5e5-4f21-a03b-bc60182f6293', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5bbed123-e5e5-4f21-a03b-bc60182f6293', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5bbed123-e5e5-4f21-a03b-bc60182f6293', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5bbed123-e5e5-4f21-a03b-bc60182f6293', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5bbed123-e5e5-4f21-a03b-bc60182f6293', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('25fc948a-6a2b-4ab1-8e18-9dd71121159a', 'clientId', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('25fc948a-6a2b-4ab1-8e18-9dd71121159a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('25fc948a-6a2b-4ab1-8e18-9dd71121159a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('25fc948a-6a2b-4ab1-8e18-9dd71121159a', 'clientId', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('25fc948a-6a2b-4ab1-8e18-9dd71121159a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7af71785-1a32-4ce2-8d0b-153fb54cf84d', 'clientHost', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7af71785-1a32-4ce2-8d0b-153fb54cf84d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7af71785-1a32-4ce2-8d0b-153fb54cf84d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7af71785-1a32-4ce2-8d0b-153fb54cf84d', 'clientHost', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7af71785-1a32-4ce2-8d0b-153fb54cf84d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('793c4824-1ef6-44e3-b53f-6a282e142917', 'clientAddress', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('793c4824-1ef6-44e3-b53f-6a282e142917', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('793c4824-1ef6-44e3-b53f-6a282e142917', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('793c4824-1ef6-44e3-b53f-6a282e142917', 'clientAddress', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('793c4824-1ef6-44e3-b53f-6a282e142917', 'String', 'jsonType.label');


--
-- TOC entry 4149 (class 0 OID 16439)
-- Dependencies: 223
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) VALUES ('master', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, '59533569-54f7-4686-b7ba-7346241d1be6', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '2c69625b-688c-4ff3-984c-ee1ea9389133', '93dd0931-17e2-470c-a32a-2760e254ff5b', 'c216bfd3-be28-4da8-acb3-ffbb170d57c8', '96466767-6a6b-4eb1-85df-a11a6a90c8d3', '0b5b3be6-73db-4a1f-8b77-9667565cbf2c', 2592000, false, 900, true, false, '0a3944f5-8d81-4f6a-88c2-1f6d86faf5b6', 0, false, 0, 0, '76c71245-4328-4c0e-8efc-0ba93dd9cae5');
INSERT INTO public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) VALUES ('CRG', 60, 300, 300, NULL, NULL, NULL, true, false, 0, NULL, 'CRG', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, '88464ba2-f74b-407a-ac8a-38d83e763db8', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '56c176fb-14cc-4fc9-9909-7acc1b3a6639', '9e0dcc8a-4f14-4716-b7c1-39cbe055491f', 'a1dd9f36-fe5b-4781-85d0-c0e5b8c8c911', 'e7905d30-68c8-41e7-993b-51eccc8af482', '6761d32e-b13d-4f88-b71d-b3477e3a8587', 2592000, false, 900, true, false, '03ad5c2f-f75a-4fb4-b665-3acb5abd0ec7', 0, false, 0, 0, '59a0fcbc-58e9-49d9-a13b-bad975f4ae0c');


--
-- TOC entry 4150 (class 0 OID 16456)
-- Dependencies: 224
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicyReportOnly', 'master', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xContentTypeOptions', 'master', 'nosniff');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xRobotsTag', 'master', 'none');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xFrameOptions', 'master', 'SAMEORIGIN');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicy', 'master', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xXSSProtection', 'master', '1; mode=block');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.strictTransportSecurity', 'master', 'max-age=31536000; includeSubDomains');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('bruteForceProtected', 'master', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('permanentLockout', 'master', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxFailureWaitSeconds', 'master', '900');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('minimumQuickLoginWaitSeconds', 'master', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('waitIncrementSeconds', 'master', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('quickLoginCheckMilliSeconds', 'master', '1000');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxDeltaTimeSeconds', 'master', '43200');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('failureFactor', 'master', '30');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('displayName', 'master', 'Keycloak');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('displayNameHtml', 'master', '<div class="kc-logo-text"><span>Keycloak</span></div>');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('defaultSignatureAlgorithm', 'master', 'RS256');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespanEnabled', 'master', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespan', 'master', '5184000');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('oauth2DeviceCodeLifespan', 'CRG', '600');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('oauth2DevicePollingInterval', 'CRG', '5');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('cibaBackchannelTokenDeliveryMode', 'CRG', 'poll');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('cibaExpiresIn', 'CRG', '120');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('cibaInterval', 'CRG', '5');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('cibaAuthRequestedUserHint', 'CRG', 'login_hint');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('parRequestUriLifespan', 'CRG', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('userProfileEnabled', 'CRG', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('displayName', 'CRG', 'Characters Relations Graph');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('bruteForceProtected', 'CRG', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('permanentLockout', 'CRG', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxFailureWaitSeconds', 'CRG', '900');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('minimumQuickLoginWaitSeconds', 'CRG', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('waitIncrementSeconds', 'CRG', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('quickLoginCheckMilliSeconds', 'CRG', '1000');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxDeltaTimeSeconds', 'CRG', '43200');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('failureFactor', 'CRG', '30');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('actionTokenGeneratedByAdminLifespan', 'CRG', '43200');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('actionTokenGeneratedByUserLifespan', 'CRG', '300');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('defaultSignatureAlgorithm', 'CRG', 'RS256');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespanEnabled', 'CRG', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespan', 'CRG', '5184000');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('clientSessionIdleTimeout', 'CRG', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('clientSessionMaxLifespan', 'CRG', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('clientOfflineSessionIdleTimeout', 'CRG', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('clientOfflineSessionMaxLifespan', 'CRG', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpEntityName', 'CRG', 'keycloak');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicySignatureAlgorithms', 'CRG', 'ES256');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpId', 'CRG', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAttestationConveyancePreference', 'CRG', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAuthenticatorAttachment', 'CRG', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRequireResidentKey', 'CRG', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyUserVerificationRequirement', 'CRG', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyCreateTimeout', 'CRG', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegister', 'CRG', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpEntityNamePasswordless', 'CRG', 'keycloak');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicySignatureAlgorithmsPasswordless', 'CRG', 'ES256');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpIdPasswordless', 'CRG', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAttestationConveyancePreferencePasswordless', 'CRG', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAuthenticatorAttachmentPasswordless', 'CRG', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRequireResidentKeyPasswordless', 'CRG', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyUserVerificationRequirementPasswordless', 'CRG', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyCreateTimeoutPasswordless', 'CRG', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless', 'CRG', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('client-policies.profiles', 'CRG', '{"profiles":[]}');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('client-policies.policies', 'CRG', '{"policies":[]}');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicyReportOnly', 'CRG', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xContentTypeOptions', 'CRG', 'nosniff');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xRobotsTag', 'CRG', 'none');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xFrameOptions', 'CRG', 'SAMEORIGIN');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicy', 'CRG', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xXSSProtection', 'CRG', '1; mode=block');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.strictTransportSecurity', 'CRG', 'max-age=31536000; includeSubDomains');


--
-- TOC entry 4198 (class 0 OID 17213)
-- Dependencies: 272
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4175 (class 0 OID 16909)
-- Dependencies: 249
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4151 (class 0 OID 16464)
-- Dependencies: 225
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm_events_listeners (realm_id, value) VALUES ('master', 'jboss-logging');
INSERT INTO public.realm_events_listeners (realm_id, value) VALUES ('CRG', 'jboss-logging');


--
-- TOC entry 4231 (class 0 OID 17919)
-- Dependencies: 305
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4152 (class 0 OID 16467)
-- Dependencies: 226
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm_required_credential (type, form_label, input, secret, realm_id) VALUES ('password', 'password', true, true, 'master');
INSERT INTO public.realm_required_credential (type, form_label, input, secret, realm_id) VALUES ('password', 'password', true, true, 'CRG');


--
-- TOC entry 4153 (class 0 OID 16474)
-- Dependencies: 227
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4173 (class 0 OID 16825)
-- Dependencies: 247
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4154 (class 0 OID 16484)
-- Dependencies: 228
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.redirect_uris (client_id, value) VALUES ('7d0e8031-37aa-4cf7-ab11-3eb40df011af', '/realms/master/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('2875f6df-1a0e-463b-a362-593f26e8fa79', '/realms/master/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('abac7ebf-4c69-4275-bb77-760a19933344', '/admin/master/console/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('f6b41486-3352-4580-af22-418607631beb', '/realms/CRG/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('596d2e5a-b4eb-4b95-b725-dc582921b997', '/realms/CRG/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('7a249ae3-dfb6-460a-b488-f44ef5d37554', '/admin/CRG/console/*');


--
-- TOC entry 4191 (class 0 OID 17148)
-- Dependencies: 265
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4190 (class 0 OID 17141)
-- Dependencies: 264
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('0d8a1916-44ac-4b93-9f47-3a0589240596', 'VERIFY_EMAIL', 'Verify Email', 'master', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('e4551415-2a8a-4b44-9445-cfc574cb1103', 'UPDATE_PROFILE', 'Update Profile', 'master', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('8542e319-3636-479e-9822-ced3d3e5d5e9', 'CONFIGURE_TOTP', 'Configure OTP', 'master', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('eb811310-30c4-40a8-b890-eb513c8d865c', 'UPDATE_PASSWORD', 'Update Password', 'master', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('780e5df3-44b5-43ef-af48-3beb62a444b8', 'terms_and_conditions', 'Terms and Conditions', 'master', false, false, 'terms_and_conditions', 20);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('c9b33eb9-f74d-4194-bc76-89c5e362aacd', 'update_user_locale', 'Update User Locale', 'master', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('99968554-6ec8-4e3e-826a-419f0a426050', 'delete_account', 'Delete Account', 'master', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('025789ec-66b1-4bb6-ac59-a7db5bd25543', 'VERIFY_EMAIL', 'Verify Email', 'CRG', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('04c212d6-e701-4530-baa9-299a54c39829', 'UPDATE_PROFILE', 'Update Profile', 'CRG', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('a35b220b-4cd6-4116-8d79-fcf77f15dd80', 'CONFIGURE_TOTP', 'Configure OTP', 'CRG', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('8a1585eb-ad15-438f-a2fd-dea5f992897e', 'UPDATE_PASSWORD', 'Update Password', 'CRG', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('24fff964-95f9-468b-8dad-48649c1b741a', 'terms_and_conditions', 'Terms and Conditions', 'CRG', false, false, 'terms_and_conditions', 20);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('9d100c01-cc22-4091-a00a-fb9892a3e06c', 'update_user_locale', 'Update User Locale', 'CRG', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('66553a07-f820-4fbc-b44a-8b9951bf7003', 'delete_account', 'Delete Account', 'CRG', false, false, 'delete_account', 60);


--
-- TOC entry 4228 (class 0 OID 17848)
-- Dependencies: 302
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4208 (class 0 OID 17432)
-- Dependencies: 282
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4207 (class 0 OID 17417)
-- Dependencies: 281
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4202 (class 0 OID 17355)
-- Dependencies: 276
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4227 (class 0 OID 17824)
-- Dependencies: 301
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4205 (class 0 OID 17391)
-- Dependencies: 279
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4203 (class 0 OID 17363)
-- Dependencies: 277
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4204 (class 0 OID 17377)
-- Dependencies: 278
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4229 (class 0 OID 17866)
-- Dependencies: 303
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4230 (class 0 OID 17876)
-- Dependencies: 304
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4155 (class 0 OID 16487)
-- Dependencies: 229
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('2875f6df-1a0e-463b-a362-593f26e8fa79', 'f03b89ac-8890-49f4-88b4-e0ca69298469');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('596d2e5a-b4eb-4b95-b725-dc582921b997', '1408df24-7005-4e50-8e3b-9bfe74d0cccf');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'abe5f2c0-788b-46bc-aaf8-3109ad83ff2a');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '78c21f6b-d765-4689-a7a1-ae3ec65d1b98');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '59a0fcbc-58e9-49d9-a13b-bad975f4ae0c');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '3b828ec7-2243-425d-8605-60cd2e4850e9');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '530ab842-3c42-4db1-9eb2-80fb0bba79f5');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '2e79de55-b59a-4409-9cb7-330ddd7614a8');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '93ef9e8b-0510-4f74-b4b1-10f166757419');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '5eb82123-9918-4480-adcf-2c6677678c0b');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '722e35ec-c7ad-45d8-8904-e8938f28c4d0');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '8fdb94af-1a19-497c-b194-788b8dd3468d');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', 'a44a56b0-6865-44b4-81e0-72cf41fbb163');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '856881a1-8944-47fe-9afe-3fcce43c603f');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '33b2407a-7e56-40eb-9c93-4a1f2a693b53');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '977b0882-b274-403c-bf6b-af68c45d3267');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '999a5e0d-ea18-446f-a6d4-e8e191a62dca');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '971f077e-86db-4dbf-966d-76254fe9bbfa');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('29692d4c-d25b-4cca-9f60-b1b52233b532', '9d968aae-c989-4a10-acca-b9e08020dc1f');


--
-- TOC entry 4209 (class 0 OID 17447)
-- Dependencies: 283
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4157 (class 0 OID 16493)
-- Dependencies: 231
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4179 (class 0 OID 16930)
-- Dependencies: 253
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4225 (class 0 OID 17799)
-- Dependencies: 299
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4158 (class 0 OID 16498)
-- Dependencies: 232
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('4db55130-e611-4120-9323-00f7c1eac083', NULL, '7b7d8935-10b7-45ad-8136-925adc31ca72', false, true, NULL, NULL, NULL, 'master', 'admin', 1675054478700, NULL, 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('8b38bb92-f228-4ecf-900b-12649c2a77a9', NULL, '46d0b57d-56ac-4c8c-bcc6-126fd7283432', false, true, NULL, NULL, NULL, 'CRG', 'mohido', 1675055350886, NULL, 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('f66a16e2-a11e-4138-a3d6-c2b9967dd15a', NULL, '572cd7a7-c083-4491-a7d9-5a16d16153e2', false, true, NULL, NULL, NULL, 'CRG', 'service-account-crg-app', 1675055667935, '29692d4c-d25b-4cca-9f60-b1b52233b532', 0);


--
-- TOC entry 4159 (class 0 OID 16506)
-- Dependencies: 233
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4186 (class 0 OID 17042)
-- Dependencies: 260
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4187 (class 0 OID 17047)
-- Dependencies: 261
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4160 (class 0 OID 16511)
-- Dependencies: 234
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4197 (class 0 OID 17210)
-- Dependencies: 271
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_group_membership (group_id, user_id) VALUES ('ec98ba40-946f-48a5-bc1b-a7585dfec9b7', '8b38bb92-f228-4ecf-900b-12649c2a77a9');
INSERT INTO public.user_group_membership (group_id, user_id) VALUES ('ec98ba40-946f-48a5-bc1b-a7585dfec9b7', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');


--
-- TOC entry 4161 (class 0 OID 16516)
-- Dependencies: 235
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4162 (class 0 OID 16519)
-- Dependencies: 236
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('76c71245-4328-4c0e-8efc-0ba93dd9cae5', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('08d404c8-aca1-47cb-94af-d9e0654eb597', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('1444d754-6055-47de-b7af-de2ca30a7536', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('0dbb8d9e-9d98-4808-9a46-c9cc75cc8969', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('9e77084c-2977-46a8-bf97-b0f9dd0b618c', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('bd8bdfc9-b33c-4ce8-aceb-45d5a1a102e4', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('ce57c72c-892a-42e1-ae2d-aa8d86ad003e', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('d91e26b4-3955-47a2-b89c-92a4639ba6af', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('b123360b-b6b2-4e5e-8a24-c3a5ac0fdb56', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('833bbc53-d5dc-4775-b0eb-3b5f56f53ddb', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('0edfb085-e9de-4cfc-ab4c-f3c834518337', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('9dd86adc-f341-4205-9707-536e026e02e5', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('1678aa44-a238-4de5-8e4c-79ad471d8991', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('71080794-64c2-4ccf-a22c-a5b7473bbc7a', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('47940d42-7ca8-4ed1-8407-40cd20c42599', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('43f5c2c2-d25b-42b3-bdd9-6ed4e906637d', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('521d2448-460d-4fb2-8a59-4958b9af57a7', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('0de404e7-9322-460a-a1bb-75c38b0ff249', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('91fde41e-a650-4238-b085-0dfac2cbc06f', '4db55130-e611-4120-9323-00f7c1eac083');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('59a0fcbc-58e9-49d9-a13b-bad975f4ae0c', '8b38bb92-f228-4ecf-900b-12649c2a77a9');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('abe5f2c0-788b-46bc-aaf8-3109ad83ff2a', '8b38bb92-f228-4ecf-900b-12649c2a77a9');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('59a0fcbc-58e9-49d9-a13b-bad975f4ae0c', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('abe5f2c0-788b-46bc-aaf8-3109ad83ff2a', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('78c21f6b-d765-4689-a7a1-ae3ec65d1b98', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('3b828ec7-2243-425d-8605-60cd2e4850e9', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('530ab842-3c42-4db1-9eb2-80fb0bba79f5', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('bf54e3d7-3bfd-4eb5-8b98-f95400e488f4', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8a4e694a-f869-4752-8371-a6be8f1f6677', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('2e79de55-b59a-4409-9cb7-330ddd7614a8', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('e37c9b71-0f80-4777-ba1a-ce2426f12998', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('5eb82123-9918-4480-adcf-2c6677678c0b', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('017dcbbc-24ed-41d7-a52f-af655fb492f4', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8092d763-42a5-42e6-8358-c72b1bf46738', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('93ef9e8b-0510-4f74-b4b1-10f166757419', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('a44a56b0-6865-44b4-81e0-72cf41fbb163', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('856881a1-8944-47fe-9afe-3fcce43c603f', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8fdb94af-1a19-497c-b194-788b8dd3468d', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('722e35ec-c7ad-45d8-8904-e8938f28c4d0', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8fe844be-c93f-414b-864b-58ac004d212f', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('977b0882-b274-403c-bf6b-af68c45d3267', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('999a5e0d-ea18-446f-a6d4-e8e191a62dca', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('33b2407a-7e56-40eb-9c93-4a1f2a693b53', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('a0292efd-4276-465c-a803-279a05c2b0d3', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('9d968aae-c989-4a10-acca-b9e08020dc1f', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('971f077e-86db-4dbf-966d-76254fe9bbfa', 'f66a16e2-a11e-4138-a3d6-c2b9967dd15a');


--
-- TOC entry 4163 (class 0 OID 16522)
-- Dependencies: 237
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4174 (class 0 OID 16828)
-- Dependencies: 248
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4156 (class 0 OID 16490)
-- Dependencies: 230
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4164 (class 0 OID 16533)
-- Dependencies: 238
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.web_origins (client_id, value) VALUES ('abac7ebf-4c69-4275-bb77-760a19933344', '+');
INSERT INTO public.web_origins (client_id, value) VALUES ('7a249ae3-dfb6-460a-b488-f44ef5d37554', '+');


--
-- TOC entry 3683 (class 2606 OID 17591)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 3656 (class 2606 OID 17902)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3897 (class 2606 OID 17730)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3899 (class 2606 OID 17931)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3894 (class 2606 OID 17605)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3811 (class 2606 OID 17252)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3859 (class 2606 OID 17528)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3781 (class 2606 OID 17160)
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- TOC entry 3885 (class 2606 OID 17548)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3888 (class 2606 OID 17546)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3877 (class 2606 OID 17544)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3861 (class 2606 OID 17530)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3864 (class 2606 OID 17532)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3869 (class 2606 OID 17538)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3873 (class 2606 OID 17540)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3881 (class 2606 OID 17542)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3892 (class 2606 OID 17585)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3813 (class 2606 OID 17689)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3741 (class 2606 OID 17706)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3670 (class 2606 OID 17708)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3736 (class 2606 OID 17710)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3729 (class 2606 OID 16837)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3712 (class 2606 OID 16771)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3653 (class 2606 OID 16545)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3725 (class 2606 OID 16839)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3662 (class 2606 OID 16547)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3644 (class 2606 OID 16549)
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- TOC entry 3707 (class 2606 OID 16551)
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- TOC entry 3698 (class 2606 OID 16553)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3715 (class 2606 OID 16773)
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- TOC entry 3636 (class 2606 OID 16557)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3641 (class 2606 OID 16559)
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- TOC entry 3680 (class 2606 OID 16561)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3717 (class 2606 OID 16775)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3667 (class 2606 OID 16563)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3673 (class 2606 OID 16565)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3658 (class 2606 OID 16567)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3759 (class 2606 OID 17693)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3771 (class 2606 OID 17068)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3767 (class 2606 OID 17066)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3764 (class 2606 OID 17064)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3761 (class 2606 OID 17062)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3779 (class 2606 OID 17072)
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- TOC entry 3704 (class 2606 OID 16569)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3646 (class 2606 OID 17687)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3757 (class 2606 OID 16955)
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- TOC entry 3734 (class 2606 OID 16841)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3845 (class 2606 OID 17411)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3675 (class 2606 OID 16571)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3650 (class 2606 OID 16573)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3696 (class 2606 OID 16575)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3912 (class 2606 OID 17828)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3830 (class 2606 OID 17369)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3840 (class 2606 OID 17397)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3856 (class 2606 OID 17466)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3850 (class 2606 OID 17436)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3835 (class 2606 OID 17383)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3847 (class 2606 OID 17421)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3853 (class 2606 OID 17451)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3689 (class 2606 OID 16577)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3777 (class 2606 OID 17076)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3773 (class 2606 OID 17074)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3910 (class 2606 OID 17813)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3907 (class 2606 OID 17803)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3752 (class 2606 OID 16949)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3798 (class 2606 OID 17219)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3805 (class 2606 OID 17226)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3802 (class 2606 OID 17240)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3747 (class 2606 OID 16945)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3750 (class 2606 OID 17125)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3744 (class 2606 OID 16943)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3794 (class 2606 OID 17908)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3788 (class 2606 OID 17195)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3719 (class 2606 OID 16835)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3723 (class 2606 OID 17118)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3677 (class 2606 OID 17712)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3786 (class 2606 OID 17158)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3783 (class 2606 OID 17156)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3701 (class 2606 OID 17070)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3918 (class 2606 OID 17875)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3920 (class 2606 OID 17882)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3685 (class 2606 OID 17154)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3808 (class 2606 OID 17233)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3739 (class 2606 OID 16845)
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- TOC entry 3709 (class 2606 OID 17714)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3822 (class 2606 OID 17336)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3817 (class 2606 OID 17295)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3634 (class 2606 OID 16389)
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- TOC entry 3828 (class 2606 OID 17667)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3826 (class 2606 OID 17324)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3905 (class 2606 OID 17788)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3923 (class 2606 OID 17925)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3916 (class 2606 OID 17855)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3800 (class 2606 OID 17597)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3732 (class 2606 OID 16892)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3639 (class 2606 OID 16581)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3819 (class 2606 OID 17741)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3692 (class 2606 OID 16585)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3833 (class 2606 OID 17916)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3914 (class 2606 OID 17912)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3843 (class 2606 OID 17658)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3838 (class 2606 OID 17662)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3755 (class 2606 OID 17904)
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3665 (class 2606 OID 16593)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3694 (class 2606 OID 17587)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3857 (class 1259 OID 17611)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3762 (class 1259 OID 17615)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- TOC entry 3768 (class 1259 OID 17613)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- TOC entry 3769 (class 1259 OID 17612)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3765 (class 1259 OID 17614)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- TOC entry 3900 (class 1259 OID 17932)
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- TOC entry 3713 (class 1259 OID 17938)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 3637 (class 1259 OID 17917)
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- TOC entry 3895 (class 1259 OID 17655)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- TOC entry 3642 (class 1259 OID 17619)
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- TOC entry 3820 (class 1259 OID 17818)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3901 (class 1259 OID 17929)
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- TOC entry 3720 (class 1259 OID 17815)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3823 (class 1259 OID 17816)
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3886 (class 1259 OID 17621)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- TOC entry 3889 (class 1259 OID 17889)
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- TOC entry 3890 (class 1259 OID 17620)
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- TOC entry 3647 (class 1259 OID 17622)
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- TOC entry 3648 (class 1259 OID 17623)
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- TOC entry 3902 (class 1259 OID 17821)
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- TOC entry 3903 (class 1259 OID 17822)
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- TOC entry 3654 (class 1259 OID 17918)
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3726 (class 1259 OID 17354)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3727 (class 1259 OID 17353)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- TOC entry 3862 (class 1259 OID 17715)
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3865 (class 1259 OID 17735)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3866 (class 1259 OID 17900)
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3867 (class 1259 OID 17717)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3870 (class 1259 OID 17718)
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3871 (class 1259 OID 17719)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3874 (class 1259 OID 17720)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3875 (class 1259 OID 17721)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3878 (class 1259 OID 17722)
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3879 (class 1259 OID 17723)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3882 (class 1259 OID 17724)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3883 (class 1259 OID 17725)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3806 (class 1259 OID 17626)
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- TOC entry 3803 (class 1259 OID 17627)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- TOC entry 3748 (class 1259 OID 17629)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3730 (class 1259 OID 17628)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- TOC entry 3659 (class 1259 OID 17630)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- TOC entry 3660 (class 1259 OID 17631)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- TOC entry 3795 (class 1259 OID 17935)
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- TOC entry 3789 (class 1259 OID 17936)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3790 (class 1259 OID 17937)
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- TOC entry 3791 (class 1259 OID 17893)
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- TOC entry 3792 (class 1259 OID 17926)
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- TOC entry 3721 (class 1259 OID 17632)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- TOC entry 3668 (class 1259 OID 17635)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- TOC entry 3815 (class 1259 OID 17814)
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- TOC entry 3814 (class 1259 OID 17636)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3671 (class 1259 OID 17639)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3742 (class 1259 OID 17638)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3663 (class 1259 OID 17634)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- TOC entry 3737 (class 1259 OID 17640)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3678 (class 1259 OID 17641)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- TOC entry 3784 (class 1259 OID 17642)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- TOC entry 3851 (class 1259 OID 17643)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- TOC entry 3848 (class 1259 OID 17644)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- TOC entry 3841 (class 1259 OID 17663)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3831 (class 1259 OID 17664)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3836 (class 1259 OID 17665)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3921 (class 1259 OID 17888)
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- TOC entry 3824 (class 1259 OID 17817)
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3681 (class 1259 OID 17648)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- TOC entry 3854 (class 1259 OID 17649)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- TOC entry 3745 (class 1259 OID 17898)
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- TOC entry 3796 (class 1259 OID 17343)
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- TOC entry 3908 (class 1259 OID 17823)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3686 (class 1259 OID 17350)
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- TOC entry 3687 (class 1259 OID 17939)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- TOC entry 3753 (class 1259 OID 17347)
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- TOC entry 3651 (class 1259 OID 17351)
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- TOC entry 3690 (class 1259 OID 17344)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- TOC entry 3809 (class 1259 OID 17346)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- TOC entry 3702 (class 1259 OID 17352)
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- TOC entry 3705 (class 1259 OID 17345)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- TOC entry 3774 (class 1259 OID 17651)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3775 (class 1259 OID 17652)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3699 (class 1259 OID 17653)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3710 (class 1259 OID 17654)
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- TOC entry 3965 (class 2606 OID 17077)
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3949 (class 2606 OID 16846)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3942 (class 2606 OID 16776)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3948 (class 2606 OID 16856)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3944 (class 2606 OID 17003)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3943 (class 2606 OID 16781)
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3952 (class 2606 OID 16886)
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- TOC entry 3925 (class 2606 OID 16596)
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3934 (class 2606 OID 16601)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3938 (class 2606 OID 16606)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3957 (class 2606 OID 16981)
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3932 (class 2606 OID 16616)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3995 (class 2606 OID 17856)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3936 (class 2606 OID 16621)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3939 (class 2606 OID 16631)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3929 (class 2606 OID 16636)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- TOC entry 3933 (class 2606 OID 16641)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3930 (class 2606 OID 16656)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3926 (class 2606 OID 16661)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3960 (class 2606 OID 17097)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- TOC entry 3961 (class 2606 OID 17092)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3959 (class 2606 OID 17087)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3958 (class 2606 OID 17082)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3924 (class 2606 OID 16666)
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- TOC entry 3940 (class 2606 OID 16671)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3972 (class 2606 OID 17762)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3973 (class 2606 OID 17752)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3966 (class 2606 OID 17166)
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3945 (class 2606 OID 17747)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3988 (class 2606 OID 17606)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3986 (class 2606 OID 17554)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- TOC entry 3987 (class 2606 OID 17549)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3971 (class 2606 OID 17253)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3964 (class 2606 OID 17112)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- TOC entry 3962 (class 2606 OID 17107)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3963 (class 2606 OID 17102)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3984 (class 2606 OID 17472)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3982 (class 2606 OID 17457)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3991 (class 2606 OID 17829)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3974 (class 2606 OID 17673)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3992 (class 2606 OID 17834)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3993 (class 2606 OID 17839)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3985 (class 2606 OID 17467)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3983 (class 2606 OID 17452)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3994 (class 2606 OID 17861)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3976 (class 2606 OID 17668)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3978 (class 2606 OID 17422)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3980 (class 2606 OID 17437)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3981 (class 2606 OID 17442)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3979 (class 2606 OID 17427)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3975 (class 2606 OID 17678)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3927 (class 2606 OID 16686)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3990 (class 2606 OID 17804)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- TOC entry 3956 (class 2606 OID 16966)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3969 (class 2606 OID 17227)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3968 (class 2606 OID 17241)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3953 (class 2606 OID 16912)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3931 (class 2606 OID 16696)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3954 (class 2606 OID 16956)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3955 (class 2606 OID 17126)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- TOC entry 3941 (class 2606 OID 16706)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3935 (class 2606 OID 16716)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3946 (class 2606 OID 16851)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3928 (class 2606 OID 16731)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3947 (class 2606 OID 17119)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- TOC entry 3989 (class 2606 OID 17789)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3967 (class 2606 OID 17161)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3996 (class 2606 OID 17869)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3997 (class 2606 OID 17883)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3951 (class 2606 OID 16881)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3937 (class 2606 OID 16751)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3970 (class 2606 OID 17234)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3977 (class 2606 OID 17412)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3950 (class 2606 OID 16861)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


-- Completed on 2023-01-30 05:20:25 UTC

--
-- PostgreSQL database dump complete
--

