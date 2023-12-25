--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_identity (
    "userId" uuid,
    "providerId" character varying(64) NOT NULL,
    "providerType" character varying(32) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE public.auth_identity OWNER TO postgres;

--
-- Name: auth_provider_sync_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_provider_sync_history (
    id integer NOT NULL,
    "providerType" character varying(32) NOT NULL,
    "runMode" text NOT NULL,
    status text NOT NULL,
    "startedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "endedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    scanned integer NOT NULL,
    created integer NOT NULL,
    updated integer NOT NULL,
    disabled integer NOT NULL,
    error text
);


ALTER TABLE public.auth_provider_sync_history OWNER TO postgres;

--
-- Name: auth_provider_sync_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_provider_sync_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_provider_sync_history_id_seq OWNER TO postgres;

--
-- Name: auth_provider_sync_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_provider_sync_history_id_seq OWNED BY public.auth_provider_sync_history.id;


--
-- Name: credentials_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credentials_entity (
    name character varying(128) NOT NULL,
    data text NOT NULL,
    type character varying(128) NOT NULL,
    "nodesAccess" json NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    id character varying(36) NOT NULL
);


ALTER TABLE public.credentials_entity OWNER TO postgres;

--
-- Name: event_destinations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_destinations (
    id uuid NOT NULL,
    destination jsonb NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE public.event_destinations OWNER TO postgres;

--
-- Name: execution_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.execution_data (
    "executionId" integer NOT NULL,
    "workflowData" json NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.execution_data OWNER TO postgres;

--
-- Name: execution_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.execution_entity (
    id integer NOT NULL,
    finished boolean NOT NULL,
    mode character varying NOT NULL,
    "retryOf" character varying,
    "retrySuccessId" character varying,
    "startedAt" timestamp(3) with time zone NOT NULL,
    "stoppedAt" timestamp(3) with time zone,
    "waitTill" timestamp(3) with time zone,
    status character varying,
    "workflowId" character varying(36) NOT NULL,
    "deletedAt" timestamp(3) with time zone
);


ALTER TABLE public.execution_entity OWNER TO postgres;

--
-- Name: execution_entity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.execution_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.execution_entity_id_seq OWNER TO postgres;

--
-- Name: execution_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.execution_entity_id_seq OWNED BY public.execution_entity.id;


--
-- Name: execution_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.execution_metadata (
    id integer NOT NULL,
    "executionId" integer NOT NULL,
    key text NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.execution_metadata OWNER TO postgres;

--
-- Name: execution_metadata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.execution_metadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.execution_metadata_id_seq OWNER TO postgres;

--
-- Name: execution_metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.execution_metadata_id_seq OWNED BY public.execution_metadata.id;


--
-- Name: installed_nodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.installed_nodes (
    name character varying(200) NOT NULL,
    type character varying(200) NOT NULL,
    "latestVersion" integer DEFAULT 1 NOT NULL,
    package character varying(241) NOT NULL
);


ALTER TABLE public.installed_nodes OWNER TO postgres;

--
-- Name: installed_packages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.installed_packages (
    "packageName" character varying(214) NOT NULL,
    "installedVersion" character varying(50) NOT NULL,
    "authorName" character varying(70),
    "authorEmail" character varying(70),
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE public.installed_packages OWNER TO postgres;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    scope character varying(255) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_id_seq OWNER TO postgres;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    "loadOnStartup" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- Name: shared_credentials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shared_credentials (
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "roleId" integer NOT NULL,
    "userId" uuid NOT NULL,
    "credentialsId" character varying(36) NOT NULL
);


ALTER TABLE public.shared_credentials OWNER TO postgres;

--
-- Name: shared_workflow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shared_workflow (
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "roleId" integer NOT NULL,
    "userId" uuid NOT NULL,
    "workflowId" character varying(36) NOT NULL
);


ALTER TABLE public.shared_workflow OWNER TO postgres;

--
-- Name: tag_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag_entity (
    name character varying(24) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    id character varying(36) NOT NULL
);


ALTER TABLE public.tag_entity OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id uuid DEFAULT uuid_in((OVERLAY(OVERLAY(md5((((random())::text || ':'::text) || (clock_timestamp())::text)) PLACING '4'::text FROM 13) PLACING to_hex((floor(((random() * (((11 - 8) + 1))::double precision) + (8)::double precision)))::integer) FROM 17))::cstring) NOT NULL,
    email character varying(255),
    "firstName" character varying(32),
    "lastName" character varying(32),
    password character varying(255),
    "personalizationAnswers" json,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "globalRoleId" integer NOT NULL,
    settings json,
    "apiKey" character varying(255),
    disabled boolean DEFAULT false NOT NULL,
    "mfaEnabled" boolean DEFAULT false NOT NULL,
    "mfaSecret" text,
    "mfaRecoveryCodes" text
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: variables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.variables (
    key character varying(50) NOT NULL,
    type character varying(50) DEFAULT 'string'::character varying NOT NULL,
    value character varying(255),
    id character varying(36) NOT NULL
);


ALTER TABLE public.variables OWNER TO postgres;

--
-- Name: webhook_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.webhook_entity (
    "webhookPath" character varying NOT NULL,
    method character varying NOT NULL,
    node character varying NOT NULL,
    "webhookId" character varying,
    "pathLength" integer,
    "workflowId" character varying(36) NOT NULL
);


ALTER TABLE public.webhook_entity OWNER TO postgres;

--
-- Name: workflow_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_entity (
    name character varying(128) NOT NULL,
    active boolean NOT NULL,
    nodes json NOT NULL,
    connections json NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    settings json,
    "staticData" json,
    "pinData" json,
    "versionId" character(36),
    "triggerCount" integer DEFAULT 0 NOT NULL,
    id character varying(36) NOT NULL,
    meta json
);


ALTER TABLE public.workflow_entity OWNER TO postgres;

--
-- Name: workflow_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_history (
    "versionId" character varying(36) NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    authors character varying(255) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    nodes json NOT NULL,
    connections json NOT NULL
);


ALTER TABLE public.workflow_history OWNER TO postgres;

--
-- Name: workflow_statistics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_statistics (
    count integer DEFAULT 0,
    "latestEvent" timestamp(3) with time zone,
    name character varying(128) NOT NULL,
    "workflowId" character varying(36) NOT NULL
);


ALTER TABLE public.workflow_statistics OWNER TO postgres;

--
-- Name: workflows_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflows_tags (
    "workflowId" character varying(36) NOT NULL,
    "tagId" character varying(36) NOT NULL
);


ALTER TABLE public.workflows_tags OWNER TO postgres;

--
-- Name: auth_provider_sync_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_provider_sync_history ALTER COLUMN id SET DEFAULT nextval('public.auth_provider_sync_history_id_seq'::regclass);


--
-- Name: execution_entity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.execution_entity ALTER COLUMN id SET DEFAULT nextval('public.execution_entity_id_seq'::regclass);


--
-- Name: execution_metadata id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.execution_metadata ALTER COLUMN id SET DEFAULT nextval('public.execution_metadata_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- Data for Name: auth_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_identity ("userId", "providerId", "providerType", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: auth_provider_sync_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_provider_sync_history (id, "providerType", "runMode", status, "startedAt", "endedAt", scanned, created, updated, disabled, error) FROM stdin;
\.


--
-- Data for Name: credentials_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credentials_entity (name, data, type, "nodesAccess", "createdAt", "updatedAt", id) FROM stdin;
OpenAi account	U2FsdGVkX184uFUabKkrECpKvTxMbwsR0LaB8IUI/nosOSqT5QOjfbPpyntj7pZ7UdvPnf6c3QcZ4RtTNHNK+1bTchGeOWefX8r2eb82EddKxPeUdQcey85PEXsoE3J8	openAiApi	[{"nodeType":"n8n-nodes-base.openAi","date":"2023-12-04T07:32:39.174Z"}]	2023-12-04 13:02:39.189+05:30	2023-12-04 13:02:39.174+05:30	TmXFa0qxX1jMfCDX
FM ACS	U2FsdGVkX1+qhr2aKQdiivmrYlwPRb7zGWSmvOCTTYyZYIWmELn6XcRsypysEJfs62/SyXid9lnMJGurULVHRiqvzv+i0O9liJtoNfGIrauflkWc6+ICEMHiacn1HEwuZyZg/JmpBm2rT3sI4Dbm+A==	fileMaker	[{"nodeType":"n8n-nodes-base.filemaker","date":"2023-12-14T18:09:24.659Z"}]	2023-12-14 23:39:24.676+05:30	2023-12-14 23:39:24.659+05:30	cmnqgly3iaScaPTk
FileMaker Kitrack	U2FsdGVkX1/HUv8TseFLIP28BJvdbV4OdjVN29w8wUtYknvXpd11x80/95Qgg4fWcdleNpUmepDBkfYE1ocCF83W4FKfBO4WN7FfHhvfQEj774vKPm1EPA4nmPKTpUg/3kntaUiPsPc2is/PO4Tp1g==	fileMaker	[{"nodeType":"n8n-nodes-base.filemaker","date":"2023-12-08T11:02:37.029Z"}]	2023-12-08 16:32:37.033+05:30	2023-12-08 16:45:18.816+05:30	gEglOSZCWsdQnsVH
FileMaker Copilot	U2FsdGVkX19ECZb6XyWVGBhk3GwxniWpGACOFXoVdHdT68e/oeRczmpF1RG1Uley5keuZHWPphHCuFmkGaRSVqHlsHIDbyqGHZTWoZmy5OmQS5yN+DM0Lo8abkrqgwXBp92suI1M+GX4mJgf4iK5tg==	fileMaker	[{"nodeType":"n8n-nodes-base.filemaker","date":"2023-12-01T18:48:32.467Z"}]	2023-12-02 00:18:32.487+05:30	2023-12-08 16:45:36.207+05:30	I8ExAqx9BKMq6guU
FileMaker account	U2FsdGVkX1/AQWWiNDvzJzxLbGgnGGGtdWX+aAm+EjwP3SY2Y8DOjZ2cVBBP80PH/5pkWTusW5yyWs/75FLFEJHA8bqfuYJ5gNoAo+/jdEsUdpgxe9pZlYVFYKZUQVfKjiaiXvpIdpTZwGx00etObWsS3BI0tUu4lXFLaqtAcLk=	fileMaker	[{"nodeType":"n8n-nodes-base.filemaker","date":"2023-12-11T16:00:32.039Z"}]	2023-12-11 21:30:32.056+05:30	2023-12-11 21:30:32.039+05:30	CCxrCgheR8xukUlJ
HubSpot Developer account	U2FsdGVkX19SRvI9QCSe0oWiaWXXodDOdYNb+mPVEtWSbUXOVkcqv8rDLBWu+ZEcIOk3BCOGiKhRIY3LkmCxeXcGyMp6D2c42bWuFMV09Ga1IlwOgaTMFLH+vBEEiID36L4qnrz2EzCP9DGC5p9zKUR9XJV8jESm4PViez422AM3s8P20prP0j814hgN02ccwWXrzkv4YLl3qMoojgi3a00M4RGsGEMSAuvukS+4kUjra5nq4Lll4V7npRQHD1JaGW7tz2/gqRmBR8uaJ/zRw+azS/1mq17lvgK0h3vGNVb0pc2+UirTvHDeYRqNnaXC	hubspotDeveloperApi	[{"nodeType":"n8n-nodes-base.hubspotTrigger","date":"2023-12-19T18:11:30.248Z"}]	2023-12-19 23:33:17.046+05:30	2023-12-19 23:41:30.561+05:30	U7LnCriqV19mjk78
ClickUp account	U2FsdGVkX1/gVCRMgsYA2XY/Bl2CZgrp2vP4DYa/BQCsfg2ZHIh6wL/fbBFez5HIBkErLPKaeQh3EpMpZY9Eltcezrq9Gv5Wmj34hma36v7ZdPO5qRoT2V8nGcNHzKU/oPnzbC5rdjBc31mujZPm5DVXBVw5JJHqjRDoFUFaTjeou2PTqj5Wj+QIvBBVaaByYtXjMNBhqbTFIE6xP3J4Csa5XNkrEb8QxcSrvLYBIYu1GdFmdHvCcElm2Vf81IJXCphfm+QUTf5057CnwlvgQP7X9S5IJHOcne0fM0poAcntjQkWRXdVo/5LTxFT/p1LNt5nxseTCKmKzxzWPQ5ytvw/2q2+JB7hjpcoYu62QID/aoM3z1KLmsZgJmdWizO9	clickUpOAuth2Api	[{"nodeType":"n8n-nodes-base.clickUp","date":"2023-12-13T21:05:01.254Z"},{"nodeType":"n8n-nodes-base.clickUpTrigger","date":"2023-12-13T21:05:01.254Z"}]	2023-12-14 02:34:58.858+05:30	2023-12-14 02:35:08.473+05:30	X4HWQIToPkAyMn7M
ClickUp account 2	U2FsdGVkX19GMF1j2BDjs62R8vrzmBbcOsBx/y2wduV8ZfxZV1k6Xp5Bl4LP7w/pH/f4MLL6WxhT4qvxK7jP8347kjfmWS8JWcBwp7FPwcs=	clickUpApi	[{"nodeType":"n8n-nodes-base.clickUp","date":"2023-12-13T21:07:13.005Z"},{"nodeType":"n8n-nodes-base.clickUpTrigger","date":"2023-12-13T21:07:13.005Z"}]	2023-12-14 02:37:13.012+05:30	2023-12-14 02:37:13.005+05:30	XCn8g5Tb3w7VGyVZ
FileMaker Kopilot	U2FsdGVkX1/+4dKSQf4JS5lWDElSSw27brtAc4+BvotuKQyqgcpiYhtimDvLvagpGCHoVwf89uyBca5HOF8UdF6adDpnWFEL21d2e2VcuN0f6EYbMyhFOIHkuLCbFBbCvgjlc5mOEnPzZuOb52mlEQ==	fileMaker	[{"nodeType":"n8n-nodes-base.filemaker","date":"2023-12-20T11:39:44.166Z"}]	2023-12-20 17:09:44.178+05:30	2023-12-20 17:10:44.511+05:30	rlVsLA3BIbB1jw3C
\.


--
-- Data for Name: event_destinations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_destinations (id, destination, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: execution_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.execution_data ("executionId", "workflowData", data) FROM stdin;
\.


--
-- Data for Name: execution_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.execution_entity (id, finished, mode, "retryOf", "retrySuccessId", "startedAt", "stoppedAt", "waitTill", status, "workflowId", "deletedAt") FROM stdin;
\.


--
-- Data for Name: execution_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.execution_metadata (id, "executionId", key, value) FROM stdin;
\.


--
-- Data for Name: installed_nodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.installed_nodes (name, type, "latestVersion", package) FROM stdin;
\.


--
-- Data for Name: installed_packages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.installed_packages ("packageName", "installedVersion", "authorName", "authorEmail", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, "timestamp", name) FROM stdin;
1	1587669153312	InitialMigration1587669153312
2	1589476000887	WebhookModel1589476000887
3	1594828256133	CreateIndexStoppedAt1594828256133
4	1607431743768	MakeStoppedAtNullable1607431743768
5	1611144599516	AddWebhookId1611144599516
6	1617270242566	CreateTagEntity1617270242566
7	1620824779533	UniqueWorkflowNames1620824779533
8	1626176912946	AddwaitTill1626176912946
9	1630419189837	UpdateWorkflowCredentials1630419189837
10	1644422880309	AddExecutionEntityIndexes1644422880309
11	1646834195327	IncreaseTypeVarcharLimit1646834195327
12	1646992772331	CreateUserManagement1646992772331
13	1648740597343	LowerCaseUserEmail1648740597343
14	1652254514002	CommunityNodes1652254514002
15	1652367743993	AddUserSettings1652367743993
16	1652905585850	AddAPIKeyColumn1652905585850
17	1654090467022	IntroducePinData1654090467022
18	1658932090381	AddNodeIds1658932090381
19	1659902242948	AddJsonKeyPinData1659902242948
20	1660062385367	CreateCredentialsUserRole1660062385367
21	1663755770893	CreateWorkflowsEditorRole1663755770893
22	1664196174001	WorkflowStatistics1664196174001
23	1665484192212	CreateCredentialUsageTable1665484192212
24	1665754637025	RemoveCredentialUsageTable1665754637025
25	1669739707126	AddWorkflowVersionIdColumn1669739707126
26	1669823906995	AddTriggerCountColumn1669823906995
27	1671535397530	MessageEventBusDestinations1671535397530
28	1671726148421	RemoveWorkflowDataLoadedFlag1671726148421
29	1673268682475	DeleteExecutionsWithWorkflows1673268682475
30	1674138566000	AddStatusToExecutions1674138566000
31	1674509946020	CreateLdapEntities1674509946020
32	1675940580449	PurgeInvalidWorkflowConnections1675940580449
33	1676996103000	MigrateExecutionStatus1676996103000
34	1677236854063	UpdateRunningExecutionStatus1677236854063
35	1677501636754	CreateVariables1677501636754
36	1679416281778	CreateExecutionMetadataTable1679416281778
37	1681134145996	AddUserActivatedProperty1681134145996
38	1681134145997	RemoveSkipOwnerSetup1681134145997
39	1690000000000	MigrateIntegerKeysToString1690000000000
40	1690000000020	SeparateExecutionData1690000000020
41	1690000000030	RemoveResetPasswordColumns1690000000030
42	1690000000030	AddMfaColumns1690000000030
43	1690787606731	AddMissingPrimaryKeyOnExecutionData1690787606731
44	1691088862123	CreateWorkflowNameIndex1691088862123
45	1692967111175	CreateWorkflowHistoryTable1692967111175
46	1693491613982	ExecutionSoftDelete1693491613982
47	1693554410387	DisallowOrphanExecutions1693554410387
48	1694091729095	MigrateToTimestampTz1694091729095
49	1695128658538	AddWorkflowMetadata1695128658538
50	1695829275184	ModifyWorkflowHistoryNodesAndConnections1695829275184
51	1700571993961	AddGlobalAdminRole1700571993961
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id, name, scope, "createdAt", "updatedAt") FROM stdin;
1	owner	global	2023-12-01 11:04:05.445+05:30	2023-12-01 11:04:05.445+05:30
2	member	global	2023-12-01 11:04:05.445+05:30	2023-12-01 11:04:05.445+05:30
3	owner	workflow	2023-12-01 11:04:05.445+05:30	2023-12-01 11:04:05.445+05:30
4	owner	credential	2023-12-01 11:04:05.445+05:30	2023-12-01 11:04:05.445+05:30
5	user	credential	2023-12-01 11:04:05.891+05:30	2023-12-01 11:04:05.891+05:30
6	editor	workflow	2023-12-01 11:04:05.898+05:30	2023-12-01 11:04:05.898+05:30
7	admin	global	2023-12-01 17:24:57.641+05:30	2023-12-01 17:24:57.641+05:30
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (key, value, "loadOnStartup") FROM stdin;
ui.banners.dismissed	["V1"]	t
features.ldap	{"loginEnabled":false,"loginLabel":"","connectionUrl":"","allowUnauthorizedCerts":false,"connectionSecurity":"none","connectionPort":389,"baseDn":"","bindingAdminDn":"","bindingAdminPassword":"","firstNameAttribute":"","lastNameAttribute":"","emailAttribute":"","loginIdAttribute":"","ldapIdAttribute":"","userFilter":"","synchronizationEnabled":false,"synchronizationInterval":60,"searchPageSize":0,"searchTimeout":60}	t
features.sourceControl	{"branchName":"main"}	t
userManagement.isInstanceOwnerSetUp	true	t
\.


--
-- Data for Name: shared_credentials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shared_credentials ("createdAt", "updatedAt", "roleId", "userId", "credentialsId") FROM stdin;
2023-12-02 00:18:32.487+05:30	2023-12-02 00:18:32.487+05:30	4	ad488962-7768-40bc-8265-de9aadb55a7b	I8ExAqx9BKMq6guU
2023-12-04 13:02:39.189+05:30	2023-12-04 13:02:39.189+05:30	4	ad488962-7768-40bc-8265-de9aadb55a7b	TmXFa0qxX1jMfCDX
2023-12-08 16:32:37.033+05:30	2023-12-08 16:32:37.033+05:30	4	ad488962-7768-40bc-8265-de9aadb55a7b	gEglOSZCWsdQnsVH
2023-12-11 21:30:32.056+05:30	2023-12-11 21:30:32.056+05:30	4	ad488962-7768-40bc-8265-de9aadb55a7b	CCxrCgheR8xukUlJ
2023-12-14 02:34:58.858+05:30	2023-12-14 02:34:58.858+05:30	4	ad488962-7768-40bc-8265-de9aadb55a7b	X4HWQIToPkAyMn7M
2023-12-14 02:37:13.012+05:30	2023-12-14 02:37:13.012+05:30	4	ad488962-7768-40bc-8265-de9aadb55a7b	XCn8g5Tb3w7VGyVZ
2023-12-14 23:39:24.676+05:30	2023-12-14 23:39:24.676+05:30	4	ad488962-7768-40bc-8265-de9aadb55a7b	cmnqgly3iaScaPTk
2023-12-19 23:33:17.046+05:30	2023-12-19 23:33:17.046+05:30	4	ad488962-7768-40bc-8265-de9aadb55a7b	U7LnCriqV19mjk78
2023-12-20 17:09:44.178+05:30	2023-12-20 17:09:44.178+05:30	4	ad488962-7768-40bc-8265-de9aadb55a7b	rlVsLA3BIbB1jw3C
\.


--
-- Data for Name: shared_workflow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shared_workflow ("createdAt", "updatedAt", "roleId", "userId", "workflowId") FROM stdin;
2023-12-01 17:28:16.28+05:30	2023-12-01 17:28:16.28+05:30	3	ad488962-7768-40bc-8265-de9aadb55a7b	edfKcunKJOlwBoBu
2023-12-02 00:20:04.738+05:30	2023-12-02 00:20:04.738+05:30	3	ad488962-7768-40bc-8265-de9aadb55a7b	lJ8uOazTVMDvOmhy
2023-12-04 12:08:35.714+05:30	2023-12-04 12:08:35.714+05:30	3	ad488962-7768-40bc-8265-de9aadb55a7b	5ThbiMfl2x6PK4iT
2023-12-18 22:55:41.209+05:30	2023-12-18 22:55:41.209+05:30	3	ad488962-7768-40bc-8265-de9aadb55a7b	G0tbqQ6hjcC8s7zv
2023-12-19 20:04:50.499+05:30	2023-12-19 20:04:50.499+05:30	3	ad488962-7768-40bc-8265-de9aadb55a7b	TOMay7cerkD01ZMu
2023-12-19 22:48:15.758+05:30	2023-12-19 22:48:15.758+05:30	3	ad488962-7768-40bc-8265-de9aadb55a7b	N9CLGOUDjRUEqr8r
\.


--
-- Data for Name: tag_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag_entity (name, "createdAt", "updatedAt", id) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, "firstName", "lastName", password, "personalizationAnswers", "createdAt", "updatedAt", "globalRoleId", settings, "apiKey", disabled, "mfaEnabled", "mfaSecret", "mfaRecoveryCodes") FROM stdin;
ad488962-7768-40bc-8265-de9aadb55a7b	priya@kibizsystems.com	KiBiz	Systems	$2a$10$63vCmv4OYut8pSCXNvnSUOxV/4CQ7qsGym6BZ8Zn2rnj87Av5XLtC	{"companyType":"saas","role":"business-owner","automationBeneficiary":"my-team","companySize":"<20","reportedSource":"google","version":"v4","personalization_survey_submitted_at":"2023-12-01T11:57:59.644Z","personalization_survey_n8n_version":"1.18.0"}	2023-12-01 11:04:05.445+05:30	2023-12-19 22:47:56.282+05:30	1	{"userActivated":true,"firstSuccessfulWorkflowId":"5ThbiMfl2x6PK4iT","isOnboarded":true}	\N	f	f	\N	\N
\.


--
-- Data for Name: variables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.variables (key, type, value, id) FROM stdin;
\.


--
-- Data for Name: webhook_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.webhook_entity ("webhookPath", method, node, "webhookId", "pathLength", "workflowId") FROM stdin;
3072cbff-0770-46d5-97f7-a3b0cfb136aa	POST	Webhook	\N	\N	5ThbiMfl2x6PK4iT
75e3042b-3596-49fb-ac4f-ee1fb82381cf/webhook	POST	ClickUp Time Track Trigger	\N	\N	G0tbqQ6hjcC8s7zv
\.


--
-- Data for Name: workflow_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_entity (name, active, nodes, connections, "createdAt", "updatedAt", settings, "staticData", "pinData", "versionId", "triggerCount", id, meta) FROM stdin;
Test Workflow	f	[{"parameters":{"path":"094f7dad-e7b5-42cd-bcd4-bb644e247f89","options":{}},"id":"5c194230-256e-4750-a601-eb8a9729df00","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[880,380],"webhookId":"094f7dad-e7b5-42cd-bcd4-bb644e247f89"}]	{}	2023-12-01 17:28:16.28+05:30	2023-12-01 17:28:42.133+05:30	{"executionOrder":"v1"}	\N	{}	9008477a-7cd5-4a76-acae-aff0b76c7780	0	edfKcunKJOlwBoBu	\N
My workflow	f	[{"parameters":{},"id":"10325555-2211-4395-bbdb-3bffc1db9ef8","name":"When clicking \\"Execute Workflow\\"","type":"n8n-nodes-base.manualTrigger","typeVersion":1,"position":[220,200]},{"parameters":{"layout":"Web_CPR","recid":1},"id":"d4e12cc6-1884-40b0-abe8-733c801f33b2","name":"FileMaker","type":"n8n-nodes-base.filemaker","typeVersion":1,"position":[480,200],"credentials":{"fileMaker":{"id":"I8ExAqx9BKMq6guU","name":"FileMaker account"}}}]	{"When clicking \\"Execute Workflow\\"":{"main":[[{"node":"FileMaker","type":"main","index":0}]]}}	2023-12-02 00:20:04.738+05:30	2023-12-02 00:20:04.738+05:30	{"executionOrder":"v1"}	\N	{}	963cc774-ae33-45d5-8720-0a1e99b9b603	0	lJ8uOazTVMDvOmhy	\N
Kibiz Copilot	t	[{"parameters":{"httpMethod":"POST","path":"3072cbff-0770-46d5-97f7-a3b0cfb136aa","options":{}},"id":"195a7b9e-65d0-4c70-b6af-315cf02cb153","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[660,280],"webhookId":"3072cbff-0770-46d5-97f7-a3b0cfb136aa"},{"parameters":{"method":"POST","url":"https://api.openai.com/v1/chat/completions","authentication":"predefinedCredentialType","nodeCredentialType":"openAiApi","sendHeaders":true,"headerParameters":{"parameters":[{"name":"Content-Type","value":"application/json"}]},"sendBody":true,"specifyBody":"json","jsonBody":"={\\n    \\"messages\\": [\\n      {\\n        \\"role\\": \\"system\\",\\n        \\"content\\": \\"I am a copilot and provide inforamtion related to invoice\\"\\n      },\\n      {\\n        \\"role\\": \\"user\\",\\n        \\"content\\": \\"{{ $json.body.information.message }}\\"\\n      }\\n    ],\\n    \\"tools\\": [\\n      {\\n        \\"type\\": \\"function\\",\\n        \\"function\\": {\\n          \\"name\\": \\"InvoiceAnalysis\\",\\n          \\"description\\": \\"Give the ouptut of the prompt provided by the user and actions buttons if required depending on the prompt\\",\\n          \\"parameters\\": {\\n            \\"type\\": \\"object\\",\\n            \\"properties\\": {\\n              \\"Prompt_Response\\": {\\n                \\"type\\": \\"string\\",\\n                \\"description\\": \\"Ouptut for the user prompt\\"\\n              },\\n              \\"Action_Buttons\\": {\\n                \\"type\\": \\"array\\",\\n                \\"items\\": {\\n                  \\"type\\": \\"string\\"\\n                },\\n                \\"description\\": \\"List two possible action buttons depending on the user prompt\\"\\n              }\\n            }\\n          }\\n        }\\n      }\\n    ],\\n    \\"tool_choice\\": {\\n      \\"type\\": \\"function\\",\\n      \\"function\\": {\\n        \\"name\\": \\"InvoiceAnalysis\\"\\n      }\\n    },\\n    \\"model\\": \\"gpt-3.5-turbo\\"\\n  } ","options":{}},"id":"415ca7ae-db23-4039-8837-2a719dab1e98","name":"HTTP Request","type":"n8n-nodes-base.httpRequest","typeVersion":4.1,"position":[880,280],"credentials":{"openAiApi":{"id":"TmXFa0qxX1jMfCDX","name":"OpenAi account"}}},{"parameters":{"mode":"raw","jsonOutput":"={{ $json.choices[0].message.tool_calls[0].function.arguments }}","options":{}},"id":"1110a242-ce78-4471-a5b4-e0ccadf859d8","name":"Edit Fields","type":"n8n-nodes-base.set","typeVersion":3.2,"position":[1100,280]},{"parameters":{"action":"create","layout":"InvoicesChat","fieldsParametersUi":{"fields":[{"name":"Content","value":"=<div class=\\"response-body\\">            <div class=\\"icon-container\\">                <img src=\\"data:image/png;base64,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\\" alt=\\"Bot\\" style=\\"width: 50px; height: 50px;margin-top: 5px;\\">            </div>        <div class=\\"message bot-message\\">\\n{{ $json.Prompt_Response }}</div> </div>"},{"name":"CustomerID","value":"={{ $('Webhook').item.json.body.information.customerid }}"}]}},"id":"940e9cc8-c2d4-4954-b1eb-e1892e97ce3c","name":"FileMaker","type":"n8n-nodes-base.filemaker","typeVersion":1,"position":[1320,280],"credentials":{"fileMaker":{"id":"I8ExAqx9BKMq6guU","name":"FileMaker account"}}},{"parameters":{"conditions":{"string":[{"value1":"={{ $('Edit Fields').item.json.Action_Buttons }}","operation":"isNotEmpty"}]}},"id":"04bce605-f342-4346-bc08-012435051c51","name":"IF","type":"n8n-nodes-base.if","typeVersion":1,"position":[1540,280]},{"parameters":{"action":"edit","layout":"InvoicesOpenAI","recid":"={{ $('Webhook').item.json.body.information.id }}","modId":0,"fieldsParametersUi":{"fields":[{"name":"Constant_Button","value":"1"},{"name":"Constant_Loader","value":"0"},{"name":"button_1","value":"={{ $('Edit Fields').item.json.Action_Buttons[0] }}"},{"name":"button_2","value":"={{ $('Edit Fields').item.json.Action_Buttons[1] }}"}]}},"id":"bd2593dd-ed07-4ba9-9c69-dc6e835410b5","name":"FileMaker1","type":"n8n-nodes-base.filemaker","typeVersion":1,"position":[1880,180],"credentials":{"fileMaker":{"id":"I8ExAqx9BKMq6guU","name":"FileMaker account"}}},{"parameters":{"action":"edit","layout":"InvoicesOpenAI","recid":"={{ $('Webhook').item.json.body.information.id }}","modId":0,"fieldsParametersUi":{"fields":[{"name":"Constant_Loader","value":"0"}]}},"id":"2719fe74-23fc-4d83-af4f-f3d5742b00aa","name":"FileMaker2","type":"n8n-nodes-base.filemaker","typeVersion":1,"position":[1880,380],"credentials":{"fileMaker":{"id":"I8ExAqx9BKMq6guU","name":"FileMaker account"}}}]	{"Webhook":{"main":[[{"node":"HTTP Request","type":"main","index":0}]]},"HTTP Request":{"main":[[{"node":"Edit Fields","type":"main","index":0}]]},"Edit Fields":{"main":[[{"node":"FileMaker","type":"main","index":0}]]},"FileMaker":{"main":[[{"node":"IF","type":"main","index":0}]]},"IF":{"main":[[{"node":"FileMaker1","type":"main","index":0}],[{"node":"FileMaker2","type":"main","index":0}]]}}	2023-12-04 12:08:35.714+05:30	2023-12-04 17:58:48.733+05:30	{"executionOrder":"v1"}	\N	{}	70b6bf8d-42de-4889-a7d1-8264dd59c154	1	5ThbiMfl2x6PK4iT	\N
ClickUp Kitrack Sync	t	[{"parameters":{"authentication":"oAuth2","team":"9002139981","events":["taskTimeTrackedUpdated"],"filters":{}},"id":"5b08fd7b-b021-4f5e-b434-943ca6b2b8ce","name":"ClickUp Time Track Trigger","type":"n8n-nodes-base.clickUpTrigger","typeVersion":1,"position":[-580,620],"webhookId":"75e3042b-3596-49fb-ac4f-ee1fb82381cf","credentials":{"clickUpOAuth2Api":{"id":"X4HWQIToPkAyMn7M","name":"ClickUp account"}}},{"parameters":{"authentication":"oAuth2","operation":"get","id":"={{ $json.parent }}"},"id":"14e6c36b-1e2d-40e4-9637-a125d55685f9","name":"Click Up Parent task - Kitrack Ticket","type":"n8n-nodes-base.clickUp","typeVersion":1,"position":[-160,680],"credentials":{"clickUpOAuth2Api":{"id":"X4HWQIToPkAyMn7M","name":"ClickUp account"}}},{"parameters":{"authentication":"oAuth2","operation":"get","id":"={{ $json.task_id }}"},"id":"101847fd-4a0c-48a1-8384-73543bc8bb5d","name":"ClickUp Sub task - Activity Kitrack","type":"n8n-nodes-base.clickUp","typeVersion":1,"position":[-340,660],"credentials":{"clickUpOAuth2Api":{"id":"X4HWQIToPkAyMn7M","name":"ClickUp account"}}},{"parameters":{"conditions":{"string":[{"value1":"={{ $json.custom_fields[3].value }}","operation":"isEmpty"}]}},"id":"dc33e6d5-cd09-4c78-9efa-7bfcd5a2a1c1","name":"IF","type":"n8n-nodes-base.if","typeVersion":1,"position":[60,540]},{"parameters":{"action":"create","layout":"Ticket__Web","fieldsParametersUi":{"fields":[{"name":"ID_Project","value":"={{ $json.custom_fields[2].value }}"},{"name":"Description","value":"={{ $json.name }}"},{"name":"Features","value":"={{ $json.description }}"},{"name":"Ticket_Type","value":"={{ $json.custom_fields[0].value }}"},{"name":"TicketCategory","value":"={{ $json.custom_fields[1].value }}"}]}},"id":"6a7c0dbe-88e9-462a-9405-e765f8dc7eb3","name":"FileMaker","type":"n8n-nodes-base.filemaker","typeVersion":1,"position":[280,480],"credentials":{"fileMaker":{"id":"gEglOSZCWsdQnsVH","name":"FileMaker Kitrack"}}},{"parameters":{"authentication":"oAuth2","operation":"setCustomField","task":"={{ $('Click Up Parent task - Kitrack Ticket').item.json.id }}","field":"={{ $('Click Up Parent task - Kitrack Ticket').item.json.custom_fields[3].id }}","value":"={{ $json.response.data[0].fieldData.TicketID }}"},"id":"6b5110cf-1293-4280-a6b8-5c70eba44382","name":"ClickUp","type":"n8n-nodes-base.clickUp","typeVersion":1,"position":[640,460],"credentials":{"clickUpOAuth2Api":{"id":"X4HWQIToPkAyMn7M","name":"ClickUp account"}}},{"parameters":{"layout":"Ticket__Web","recid":"={{ $json.response.recordId }}"},"id":"220ee215-315f-431a-a10a-83e242d89cfc","name":"Get Kitrack Record","type":"n8n-nodes-base.filemaker","typeVersion":1,"position":[460,460],"credentials":{"fileMaker":{"id":"gEglOSZCWsdQnsVH","name":"FileMaker Kitrack"}}},{"parameters":{"fields":{"values":[{"name":"TicketID","stringValue":"={{ $('Get Kitrack Record').item.json.response.data[0].fieldData.TicketID }}"},{"name":"Notes","stringValue":"={{ $('ClickUp Sub task - Activity Kitrack').item.json.description }}"},{"name":"Staff","stringValue":"={{ $('ClickUp Sub task - Activity Kitrack').item.json.creator.email }}"},{"name":"Hours","stringValue":"={{ $('ClickUp Sub task - Activity Kitrack').item.json.time_spent }}"},{"name":"Summary","stringValue":"={{ $('ClickUp Sub task - Activity Kitrack').item.json.name }}"},{"name":"Billable","stringValue":"={{ $('Click Up Parent task - Kitrack Ticket').item.json.custom_fields[0].value }}"}]},"options":{}},"id":"d8c86563-5a35-4b8e-b6e7-92256add1e7e","name":"Edit Fields","type":"n8n-nodes-base.set","typeVersion":3.2,"position":[820,480]},{"parameters":{"fields":{"values":[{"name":"TicketID","stringValue":"={{ $json.custom_fields[3].value }}"},{"name":"Notes","stringValue":"={{ $json.description }}"},{"name":"Staff","stringValue":"={{ $json.creator.email }}"},{"name":"Hours","stringValue":"= {{ $('ClickUp Sub task - Activity Kitrack').item.json.time_spent }}"},{"name":"Summary","stringValue":"={{ $('ClickUp Sub task - Activity Kitrack').item.json.name }}"},{"name":"Billable","stringValue":"={{ $json.custom_fields[0].value }}"},{"name":"ClickUp_Act_ID","stringValue":"={{ $('ClickUp Sub task - Activity Kitrack').item.json.id }}"}]},"include":"selected","options":{}},"id":"ce06abe1-7346-44d7-8354-523577ead4c9","name":"Edit Fields1","type":"n8n-nodes-base.set","typeVersion":3.2,"position":[420,860]},{"parameters":{"conditions":{"string":[{"value1":"={{ $json.custom_fields[3].value }}","operation":"isNotEmpty"}]}},"id":"2b8ccdcd-b8ee-4c58-811f-9fcf5839183a","name":"IF Present","type":"n8n-nodes-base.if","typeVersion":1,"position":[80,820]},{"parameters":{"action":"performscript","layout":"Activity__Web","script":"Automate Activity Creation","scriptParam":"={ \\"TicketID\\":{{ $json.TicketID }}, \\"Staff\\":\\"{{ $json.Staff }}\\", \\"Hours\\": {{ $json.Hours }}, \\"Notes\\": \\"{{ $json.Notes }}\\", \\"Summary\\": \\"{{ $json.Summary }}\\", \\"Billable\\": \\"{{ $json.Billable }}\\", Clickup_Act:\\"{{ $json.ClickUp_Act_ID }}\\"} "},"id":"b453ffc6-e3b7-41bf-b9fb-1e45d064d344","name":"FileMaker Activity 2","type":"n8n-nodes-base.filemaker","typeVersion":1,"position":[700,880],"credentials":{"fileMaker":{"id":"gEglOSZCWsdQnsVH","name":"FileMaker Kitrack"}}},{"parameters":{"action":"performscript","layout":"Activity__Web","script":"Automate Activity Creation","scriptParam":"={ \\"TicketID\\":{{ $json.TicketID }}, \\"Staff\\":\\"{{ $json.Staff }}\\", \\"Hours\\": {{ $json.Hours }}, \\"Notes\\": \\"{{ $json.Notes }}\\", \\"Summary\\": \\"{{ $json.Summary }}\\", \\"Billable\\": \\"{{ $json.Billable }}\\"}"},"id":"857e75c1-e6f3-44c1-a5af-9570b242f177","name":"FileMaker Activity 1","type":"n8n-nodes-base.filemaker","typeVersion":1,"position":[1020,460],"credentials":{"fileMaker":{"id":"gEglOSZCWsdQnsVH","name":"FileMaker Kitrack"}}},{"parameters":{"authentication":"oAuth2","resource":"comment","commentOn":"task","id":"={{ $('ClickUp Sub task - Activity Kitrack').item.json.id }}","commentText":"=Time Logged For  {{ $('Click Up Parent task - Kitrack Ticket').item.json.custom_fields[3].value }}","additionalFields":{}},"id":"a69d184e-83af-4854-94a3-ad5ad99e8815","name":"Clickup Add Comment","type":"n8n-nodes-base.clickUp","typeVersion":1,"position":[1220,420],"credentials":{"clickUpOAuth2Api":{"id":"X4HWQIToPkAyMn7M","name":"ClickUp account"}}},{"parameters":{"authentication":"oAuth2","resource":"comment","commentOn":"task","id":"={{ $('ClickUp Sub task - Activity Kitrack').item.json.id }}","commentText":"=Time Logged For  {{ $('Click Up Parent task - Kitrack Ticket').item.json.custom_fields[3].value }}","additionalFields":{}},"id":"8a897e70-3016-41ea-8cb8-55c3914ec30b","name":"Clickup Add Comment 2","type":"n8n-nodes-base.clickUp","typeVersion":1,"position":[960,940],"credentials":{"clickUpOAuth2Api":{"id":"X4HWQIToPkAyMn7M","name":"ClickUp account"}}}]	{"ClickUp Time Track Trigger":{"main":[[{"node":"ClickUp Sub task - Activity Kitrack","type":"main","index":0}]]},"ClickUp Sub task - Activity Kitrack":{"main":[[{"node":"Click Up Parent task - Kitrack Ticket","type":"main","index":0}]]},"Click Up Parent task - Kitrack Ticket":{"main":[[{"node":"IF","type":"main","index":0},{"node":"IF Present","type":"main","index":0}]]},"IF":{"main":[[{"node":"FileMaker","type":"main","index":0}]]},"FileMaker":{"main":[[{"node":"Get Kitrack Record","type":"main","index":0}]]},"Get Kitrack Record":{"main":[[{"node":"ClickUp","type":"main","index":0}]]},"ClickUp":{"main":[[{"node":"Edit Fields","type":"main","index":0}]]},"Edit Fields":{"main":[[{"node":"FileMaker Activity 1","type":"main","index":0}]]},"IF Present":{"main":[[{"node":"Edit Fields1","type":"main","index":0}]]},"Edit Fields1":{"main":[[{"node":"FileMaker Activity 2","type":"main","index":0}]]},"FileMaker Activity 2":{"main":[[{"node":"Clickup Add Comment 2","type":"main","index":0}]]},"FileMaker Activity 1":{"main":[[{"node":"Clickup Add Comment","type":"main","index":0}]]}}	2023-12-18 22:55:41.209+05:30	2023-12-18 22:56:38.788+05:30	{"executionOrder":"v1"}	{"node:ClickUp Time Track Trigger":{"webhookId":"73093878-9c68-473a-af35-e4c01da71d43","secret":"39WSBCKVJ6W7R4IY2NSZQ7N6B456D6RYHXQV6TPPUCH22JK3KNNGIRTUV3D9UNHI"}}	{}	6b6c66d5-23f6-4108-b40e-422dc45cef90	1	G0tbqQ6hjcC8s7zv	\N
KoPilot Testing	f	[{"parameters":{"httpMethod":"POST","path":"3072cbff-0770-46d5-97f7-a3b0cfb136aa","options":{}},"id":"9839e10d-0eca-4726-94b1-8c22a92f091e","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[660,280],"webhookId":"fa042b8a-5646-4e08-bdb1-85721bc74fdc"},{"parameters":{"method":"POST","url":"https://api.openai.com/v1/chat/completions","authentication":"predefinedCredentialType","nodeCredentialType":"openAiApi","sendHeaders":true,"headerParameters":{"parameters":[{"name":"Content-Type","value":"application/json"}]},"sendBody":true,"specifyBody":"json","jsonBody":"={\\n    \\"messages\\": [\\n      {\\n        \\"role\\": \\"system\\",\\n        \\"content\\": \\"I am a copilot and provide inforamtion related to invoice\\"\\n      },\\n      {\\n        \\"role\\": \\"user\\",\\n        \\"content\\": \\"{{ $json.body.information.message }}\\"\\n      }\\n    ],\\n    \\"tools\\": [\\n      {\\n        \\"type\\": \\"function\\",\\n        \\"function\\": {\\n          \\"name\\": \\"InvoiceAnalysis\\",\\n          \\"description\\": \\"Give the ouptut of the prompt provided by the user and actions buttons if required depending on the prompt\\",\\n          \\"parameters\\": {\\n            \\"type\\": \\"object\\",\\n            \\"properties\\": {\\n              \\"Prompt_Response\\": {\\n                \\"type\\": \\"string\\",\\n                \\"description\\": \\"Ouptut for the user prompt\\"\\n              },\\n              \\"Action_Buttons\\": {\\n                \\"type\\": \\"array\\",\\n                \\"items\\": {\\n                  \\"type\\": \\"string\\"\\n                },\\n                \\"description\\": \\"List two possible action buttons depending on the user prompt\\"\\n              }\\n            }\\n          }\\n        }\\n      }\\n    ],\\n    \\"tool_choice\\": {\\n      \\"type\\": \\"function\\",\\n      \\"function\\": {\\n        \\"name\\": \\"InvoiceAnalysis\\"\\n      }\\n    },\\n    \\"model\\": \\"gpt-3.5-turbo\\"\\n  } ","options":{}},"id":"e0dc8157-5578-4cdd-a559-453dddef6e02","name":"HTTP Request","type":"n8n-nodes-base.httpRequest","typeVersion":4.1,"position":[880,280],"credentials":{"openAiApi":{"id":"TmXFa0qxX1jMfCDX","name":"OpenAi account"}}},{"parameters":{"mode":"raw","jsonOutput":"={{ $json.choices[0].message.tool_calls[0].function.arguments }}","options":{}},"id":"76896a02-2735-42bf-8c13-122800548b3b","name":"Edit Fields","type":"n8n-nodes-base.set","typeVersion":3.2,"position":[1100,280]},{"parameters":{"action":"create","layout":"InvoicesChat","fieldsParametersUi":{"fields":[{"name":"Content","value":"=<div class=\\"response-body\\">            <div class=\\"icon-container\\">                <img src=\\"data:image/png;base64,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\\" alt=\\"Bot\\" style=\\"width: 50px; height: 50px;margin-top: 5px;\\">            </div>        <div class=\\"message bot-message\\">\\n{{ $json.Prompt_Response }}</div> </div>"},{"name":"CustomerID","value":"={{ $('Webhook').item.json.body.information.customerid }}"}]}},"id":"5cfff3b8-a558-4e4d-9c75-d24aa04f4636","name":"FileMaker","type":"n8n-nodes-base.filemaker","typeVersion":1,"position":[1320,280],"credentials":{"fileMaker":{"id":"I8ExAqx9BKMq6guU","name":"FileMaker Copilot"}}},{"parameters":{"conditions":{"string":[{"value1":"={{ $('Edit Fields').item.json.Action_Buttons }}","operation":"isNotEmpty"}]}},"id":"3404f19a-4370-4356-8710-0a463d97a589","name":"IF","type":"n8n-nodes-base.if","typeVersion":1,"position":[1540,280]},{"parameters":{"action":"edit","layout":"InvoicesOpenAI","recid":"={{ $('Webhook').item.json.body.information.id }}","modId":0,"fieldsParametersUi":{"fields":[{"name":"Constant_Button","value":"1"},{"name":"Constant_Loader","value":"0"},{"name":"button_1","value":"={{ $('Edit Fields').item.json.Action_Buttons[0] }}"},{"name":"button_2","value":"={{ $('Edit Fields').item.json.Action_Buttons[1] }}"}]}},"id":"fc8a8602-41ac-4435-8e7b-2500b47998f6","name":"FileMaker1","type":"n8n-nodes-base.filemaker","typeVersion":1,"position":[1880,180],"credentials":{"fileMaker":{"id":"I8ExAqx9BKMq6guU","name":"FileMaker Copilot"}}},{"parameters":{"action":"edit","layout":"InvoicesOpenAI","recid":"={{ $('Webhook').item.json.body.information.id }}","modId":0,"fieldsParametersUi":{"fields":[{"name":"Constant_Loader","value":"0"}]}},"id":"28228b4f-dfdb-4edd-959b-08808ff8f0aa","name":"FileMaker2","type":"n8n-nodes-base.filemaker","typeVersion":1,"position":[1880,380],"credentials":{"fileMaker":{"id":"I8ExAqx9BKMq6guU","name":"FileMaker Copilot"}}},{"parameters":{"httpMethod":"POST","path":"3b173b0d-fd38-42b3-8e90-0ccf45ef061f","options":{}},"id":"15a545dc-f11b-47fa-a7dc-0d667e789897","name":"Webhook1","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[660,100],"webhookId":"3b173b0d-fd38-42b3-8e90-0ccf45ef061f"},{"parameters":{"action":"find","layout":"sa"},"id":"12094ba6-f9f8-4795-ad12-4534edaa7854","name":"FileMaker3","type":"n8n-nodes-base.filemaker","typeVersion":1,"position":[1700,280],"credentials":{"fileMaker":{"id":"I8ExAqx9BKMq6guU","name":"FileMaker Copilot"}}}]	{"Webhook":{"main":[[{"node":"HTTP Request","type":"main","index":0}]]},"HTTP Request":{"main":[[{"node":"Edit Fields","type":"main","index":0},{"node":"FileMaker3","type":"main","index":0}]]},"Edit Fields":{"main":[[{"node":"FileMaker","type":"main","index":0}]]},"FileMaker":{"main":[[{"node":"IF","type":"main","index":0}]]},"IF":{"main":[[{"node":"FileMaker1","type":"main","index":0}],[{"node":"FileMaker2","type":"main","index":0}]]}}	2023-12-19 20:04:50.499+05:30	2023-12-20 17:08:12.444+05:30	{"executionOrder":"v1"}	\N	{}	95292fa2-0146-449d-a1e4-d951eafd0dfc	1	TOMay7cerkD01ZMu	\N
Hubspot	f	[]	{}	2023-12-19 22:48:15.758+05:30	2023-12-19 22:48:15.758+05:30	{"executionOrder":"v1"}	\N	{}	2e90e9bf-55f5-4988-a68c-ebe355640adc	0	N9CLGOUDjRUEqr8r	\N
\.


--
-- Data for Name: workflow_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_history ("versionId", "workflowId", authors, "createdAt", "updatedAt", nodes, connections) FROM stdin;
\.


--
-- Data for Name: workflow_statistics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_statistics (count, "latestEvent", name, "workflowId") FROM stdin;
1	2023-12-01 17:28:18.044+05:30	data_loaded	edfKcunKJOlwBoBu
1	2023-12-01 17:28:18.29+05:30	manual_success	edfKcunKJOlwBoBu
1	2023-12-02 00:20:05.373+05:30	data_loaded	lJ8uOazTVMDvOmhy
4	2023-12-02 00:20:34.645+05:30	manual_success	lJ8uOazTVMDvOmhy
1	2023-12-04 12:49:49.66+05:30	data_loaded	5ThbiMfl2x6PK4iT
3	2023-12-09 00:11:57.763+05:30	production_error	5ThbiMfl2x6PK4iT
1	2023-12-04 16:44:49.578+05:30	manual_error	5ThbiMfl2x6PK4iT
1	2023-12-18 22:57:57.311+05:30	data_loaded	G0tbqQ6hjcC8s7zv
36	2023-12-04 17:19:17.014+05:30	manual_success	5ThbiMfl2x6PK4iT
2	2023-12-19 01:37:41.236+05:30	production_success	G0tbqQ6hjcC8s7zv
1	2023-12-20 10:02:58.1+05:30	data_loaded	TOMay7cerkD01ZMu
3	2023-12-20 17:16:34.188+05:30	manual_success	TOMay7cerkD01ZMu
29	2023-12-20 17:28:06.142+05:30	production_success	5ThbiMfl2x6PK4iT
\.


--
-- Data for Name: workflows_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflows_tags ("workflowId", "tagId") FROM stdin;
\.


--
-- Name: auth_provider_sync_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_provider_sync_history_id_seq', 1, false);


--
-- Name: execution_entity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.execution_entity_id_seq', 307, true);


--
-- Name: execution_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.execution_metadata_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 51, true);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_id_seq', 7, true);


--
-- Name: installed_packages PK_08cc9197c39b028c1e9beca225940576fd1a5804; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installed_packages
    ADD CONSTRAINT "PK_08cc9197c39b028c1e9beca225940576fd1a5804" PRIMARY KEY ("packageName");


--
-- Name: migrations PK_8c82d7f526340ab734260ea46be; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);


--
-- Name: installed_nodes PK_8ebd28194e4f792f96b5933423fc439df97d9689; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installed_nodes
    ADD CONSTRAINT "PK_8ebd28194e4f792f96b5933423fc439df97d9689" PRIMARY KEY (name);


--
-- Name: webhook_entity PK_b21ace2e13596ccd87dc9bf4ea6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook_entity
    ADD CONSTRAINT "PK_b21ace2e13596ccd87dc9bf4ea6" PRIMARY KEY ("webhookPath", method);


--
-- Name: workflow_history PK_b6572dd6173e4cd06fe79937b58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_history
    ADD CONSTRAINT "PK_b6572dd6173e4cd06fe79937b58" PRIMARY KEY ("versionId");


--
-- Name: settings PK_dc0fe14e6d9943f268e7b119f69ab8bd; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT "PK_dc0fe14e6d9943f268e7b119f69ab8bd" PRIMARY KEY (key);


--
-- Name: role PK_e853ce24e8200abe5721d2c6ac552b73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT "PK_e853ce24e8200abe5721d2c6ac552b73" PRIMARY KEY (id);


--
-- Name: user PK_ea8f538c94b6e352418254ed6474a81f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_ea8f538c94b6e352418254ed6474a81f" PRIMARY KEY (id);


--
-- Name: role UQ_5b49d0f504f7ef31045a1fb2eb8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT "UQ_5b49d0f504f7ef31045a1fb2eb8" UNIQUE (scope, name);


--
-- Name: user UQ_e12875dfb3b1d92d7d7c5377e2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e2" UNIQUE (email);


--
-- Name: auth_identity auth_identity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_identity
    ADD CONSTRAINT auth_identity_pkey PRIMARY KEY ("providerId", "providerType");


--
-- Name: auth_provider_sync_history auth_provider_sync_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_provider_sync_history
    ADD CONSTRAINT auth_provider_sync_history_pkey PRIMARY KEY (id);


--
-- Name: credentials_entity credentials_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credentials_entity
    ADD CONSTRAINT credentials_entity_pkey PRIMARY KEY (id);


--
-- Name: event_destinations event_destinations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_destinations
    ADD CONSTRAINT event_destinations_pkey PRIMARY KEY (id);


--
-- Name: execution_data execution_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.execution_data
    ADD CONSTRAINT execution_data_pkey PRIMARY KEY ("executionId");


--
-- Name: execution_metadata execution_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.execution_metadata
    ADD CONSTRAINT execution_metadata_pkey PRIMARY KEY (id);


--
-- Name: execution_entity pk_e3e63bbf986767844bbe1166d4e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.execution_entity
    ADD CONSTRAINT pk_e3e63bbf986767844bbe1166d4e PRIMARY KEY (id);


--
-- Name: shared_credentials pk_shared_credentials_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_credentials
    ADD CONSTRAINT pk_shared_credentials_id PRIMARY KEY ("userId", "credentialsId");


--
-- Name: shared_workflow pk_shared_workflow_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_workflow
    ADD CONSTRAINT pk_shared_workflow_id PRIMARY KEY ("userId", "workflowId");


--
-- Name: workflow_statistics pk_workflow_statistics; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_statistics
    ADD CONSTRAINT pk_workflow_statistics PRIMARY KEY ("workflowId", name);


--
-- Name: workflows_tags pk_workflows_tags; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflows_tags
    ADD CONSTRAINT pk_workflows_tags PRIMARY KEY ("workflowId", "tagId");


--
-- Name: tag_entity tag_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag_entity
    ADD CONSTRAINT tag_entity_pkey PRIMARY KEY (id);


--
-- Name: variables variables_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variables
    ADD CONSTRAINT variables_key_key UNIQUE (key);


--
-- Name: variables variables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variables
    ADD CONSTRAINT variables_pkey PRIMARY KEY (id);


--
-- Name: workflow_entity workflow_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_entity
    ADD CONSTRAINT workflow_entity_pkey PRIMARY KEY (id);


--
-- Name: IDX_1e31657f5fe46816c34be7c1b4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_1e31657f5fe46816c34be7c1b4" ON public.workflow_history USING btree ("workflowId");


--
-- Name: IDX_6d44376da6c1058b5e81ed8a154e1fee106046eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_6d44376da6c1058b5e81ed8a154e1fee106046eb" ON public.execution_metadata USING btree ("executionId");


--
-- Name: IDX_85b981df7b444f905f8bf50747; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_85b981df7b444f905f8bf50747" ON public.execution_entity USING btree ("waitTill", id);


--
-- Name: IDX_execution_entity_deletedAt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_execution_entity_deletedAt" ON public.execution_entity USING btree ("deletedAt");


--
-- Name: IDX_execution_entity_stoppedAt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_execution_entity_stoppedAt" ON public.execution_entity USING btree ("stoppedAt");


--
-- Name: IDX_workflow_entity_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_workflow_entity_name" ON public.workflow_entity USING btree (name);


--
-- Name: UQ_ie0zomxves9w3p774drfrkxtj5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UQ_ie0zomxves9w3p774drfrkxtj5" ON public."user" USING btree ("apiKey");


--
-- Name: idx_07fde106c0b471d8cc80a64fc8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_07fde106c0b471d8cc80a64fc8 ON public.credentials_entity USING btree (type);


--
-- Name: idx_16f4436789e804e3e1c9eeb240; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16f4436789e804e3e1c9eeb240 ON public.webhook_entity USING btree ("webhookId", method, "pathLength");


--
-- Name: idx_812eb05f7451ca757fb98444ce; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_812eb05f7451ca757fb98444ce ON public.tag_entity USING btree (name);


--
-- Name: idx_execution_entity_workflow_id_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_execution_entity_workflow_id_id ON public.execution_entity USING btree ("workflowId", id);


--
-- Name: idx_shared_credentials_credentials_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_shared_credentials_credentials_id ON public.shared_credentials USING btree ("credentialsId");


--
-- Name: idx_shared_workflow_workflow_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_shared_workflow_workflow_id ON public.shared_workflow USING btree ("workflowId");


--
-- Name: idx_workflows_tags_workflow_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_workflows_tags_workflow_id ON public.workflows_tags USING btree ("workflowId");


--
-- Name: pk_credentials_entity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX pk_credentials_entity_id ON public.credentials_entity USING btree (id);


--
-- Name: pk_tag_entity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX pk_tag_entity_id ON public.tag_entity USING btree (id);


--
-- Name: pk_variables_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX pk_variables_id ON public.variables USING btree (id);


--
-- Name: pk_workflow_entity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX pk_workflow_entity_id ON public.workflow_entity USING btree (id);


--
-- Name: workflow_history FK_1e31657f5fe46816c34be7c1b4b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_history
    ADD CONSTRAINT "FK_1e31657f5fe46816c34be7c1b4b" FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- Name: shared_workflow FK_3540da03964527aa24ae014b780; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_workflow
    ADD CONSTRAINT "FK_3540da03964527aa24ae014b780" FOREIGN KEY ("roleId") REFERENCES public.role(id);


--
-- Name: shared_credentials FK_484f0327e778648dd04f1d70493; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_credentials
    ADD CONSTRAINT "FK_484f0327e778648dd04f1d70493" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: installed_nodes FK_73f857fc5dce682cef8a99c11dbddbc969618951; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installed_nodes
    ADD CONSTRAINT "FK_73f857fc5dce682cef8a99c11dbddbc969618951" FOREIGN KEY (package) REFERENCES public.installed_packages("packageName") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shared_workflow FK_82b2fd9ec4e3e24209af8160282; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_workflow
    ADD CONSTRAINT "FK_82b2fd9ec4e3e24209af8160282" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: shared_credentials FK_c68e056637562000b68f480815a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_credentials
    ADD CONSTRAINT "FK_c68e056637562000b68f480815a" FOREIGN KEY ("roleId") REFERENCES public.role(id);


--
-- Name: user FK_f0609be844f9200ff4365b1bb3d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "FK_f0609be844f9200ff4365b1bb3d" FOREIGN KEY ("globalRoleId") REFERENCES public.role(id);


--
-- Name: auth_identity auth_identity_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_identity
    ADD CONSTRAINT "auth_identity_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- Name: execution_data execution_data_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.execution_data
    ADD CONSTRAINT execution_data_fk FOREIGN KEY ("executionId") REFERENCES public.execution_entity(id) ON DELETE CASCADE;


--
-- Name: execution_metadata execution_metadata_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.execution_metadata
    ADD CONSTRAINT execution_metadata_fk FOREIGN KEY ("executionId") REFERENCES public.execution_entity(id) ON DELETE CASCADE;


--
-- Name: execution_entity fk_execution_entity_workflow_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.execution_entity
    ADD CONSTRAINT fk_execution_entity_workflow_id FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- Name: shared_credentials fk_shared_credentials_credentials_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_credentials
    ADD CONSTRAINT fk_shared_credentials_credentials_id FOREIGN KEY ("credentialsId") REFERENCES public.credentials_entity(id) ON DELETE CASCADE;


--
-- Name: shared_workflow fk_shared_workflow_workflow_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_workflow
    ADD CONSTRAINT fk_shared_workflow_workflow_id FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- Name: webhook_entity fk_webhook_entity_workflow_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook_entity
    ADD CONSTRAINT fk_webhook_entity_workflow_id FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- Name: workflow_statistics fk_workflow_statistics_workflow_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_statistics
    ADD CONSTRAINT fk_workflow_statistics_workflow_id FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- Name: workflows_tags fk_workflows_tags_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflows_tags
    ADD CONSTRAINT fk_workflows_tags_tag_id FOREIGN KEY ("tagId") REFERENCES public.tag_entity(id) ON DELETE CASCADE;


--
-- Name: workflows_tags fk_workflows_tags_workflow_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflows_tags
    ADD CONSTRAINT fk_workflows_tags_workflow_id FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

