PGDMP                         |            shaadi    14.1    14.1                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    43029    shaadi    DATABASE     b   CREATE DATABASE shaadi WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_India.1252';
    DROP DATABASE shaadi;
                postgres    false            �            1259    43122    user_preferences    TABLE     �  CREATE TABLE public.user_preferences (
    id integer NOT NULL,
    user_id character varying(40) NOT NULL,
    from_age integer,
    to_age integer,
    from_height double precision,
    to_height double precision,
    religion text,
    sub_community text,
    mother_tongue text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 $   DROP TABLE public.user_preferences;
       public         heap    postgres    false            �            1259    43121    user_preferences_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.user_preferences_id_seq;
       public          postgres    false    213                       0    0    user_preferences_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.user_preferences_id_seq OWNED BY public.user_preferences.id;
          public          postgres    false    212            �            1259    43082    user_profile    TABLE     �  CREATE TABLE public.user_profile (
    user_id character varying(40) NOT NULL,
    dob date,
    height integer,
    gender smallint,
    city character varying(100),
    religion character varying(50),
    sub_community character varying(100),
    mother_tongue character varying(50),
    highest_qualification character varying(100),
    organization character varying(100),
    job_title character varying(100),
    monthly_income numeric(10,2),
    mother_name character varying(100),
    mother_occupation character varying(100),
    father_name character varying(100),
    father_occupation character varying(100),
    num_sisters integer,
    num_brothers integer
);
     DROP TABLE public.user_profile;
       public         heap    postgres    false            �            1259    43089 
   user_steps    TABLE     �   CREATE TABLE public.user_steps (
    user_id character varying(40) NOT NULL,
    step_number integer DEFAULT 0 NOT NULL,
    step_complete boolean DEFAULT false
);
    DROP TABLE public.user_steps;
       public         heap    postgres    false            �            1259    43040    users    TABLE     S  CREATE TABLE public.users (
    user_id character varying(40) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    name character varying(100) NOT NULL,
    phone_number character varying(10) NOT NULL,
    CONSTRAINT users_phone_number_check CHECK ((length((phone_number)::text) = 10))
);
    DROP TABLE public.users;
       public         heap    postgres    false            k           2604    43125    user_preferences id    DEFAULT     z   ALTER TABLE ONLY public.user_preferences ALTER COLUMN id SET DEFAULT nextval('public.user_preferences_id_seq'::regclass);
 B   ALTER TABLE public.user_preferences ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    212    213            
          0    43122    user_preferences 
   TABLE DATA           �   COPY public.user_preferences (id, user_id, from_age, to_age, from_height, to_height, religion, sub_community, mother_tongue, created_at, updated_at) FROM stdin;
    public          postgres    false    213   W                 0    43082    user_profile 
   TABLE DATA             COPY public.user_profile (user_id, dob, height, gender, city, religion, sub_community, mother_tongue, highest_qualification, organization, job_title, monthly_income, mother_name, mother_occupation, father_name, father_occupation, num_sisters, num_brothers) FROM stdin;
    public          postgres    false    210                    0    43089 
   user_steps 
   TABLE DATA           I   COPY public.user_steps (user_id, step_number, step_complete) FROM stdin;
    public          postgres    false    211   �                 0    43040    users 
   TABLE DATA           M   COPY public.users (user_id, email, password, name, phone_number) FROM stdin;
    public          postgres    false    209   '                   0    0    user_preferences_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.user_preferences_id_seq', 2, true);
          public          postgres    false    212            w           2606    43131 &   user_preferences user_preferences_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.user_preferences DROP CONSTRAINT user_preferences_pkey;
       public            postgres    false    213            y           2606    43133 -   user_preferences user_preferences_user_id_key 
   CONSTRAINT     k   ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_user_id_key UNIQUE (user_id);
 W   ALTER TABLE ONLY public.user_preferences DROP CONSTRAINT user_preferences_user_id_key;
       public            postgres    false    213            s           2606    43088    user_profile user_profile_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_pkey PRIMARY KEY (user_id);
 H   ALTER TABLE ONLY public.user_profile DROP CONSTRAINT user_profile_pkey;
       public            postgres    false    210            u           2606    43095    user_steps user_steps_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.user_steps
    ADD CONSTRAINT user_steps_pkey PRIMARY KEY (user_id);
 D   ALTER TABLE ONLY public.user_steps DROP CONSTRAINT user_steps_pkey;
       public            postgres    false    211            o           2606    43049    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    209            q           2606    43047    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    209            z           2606    43096 "   user_steps user_steps_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_steps
    ADD CONSTRAINT user_steps_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_profile(user_id);
 L   ALTER TABLE ONLY public.user_steps DROP CONSTRAINT user_steps_user_id_fkey;
       public          postgres    false    211    210    3187            
   �   x�m�=N�0��z|
.`k�<�H[P����m� r�BH_�H�KP&/��Qţ�a��sԒ��B�����)\��r�帿���K߷ۉ��A$}"o�M8��򇴶,�Z�G�%�����m�����1�u�i�
����m���ѿ��ǳ4�I����ذ6���-����!9�         �   x�]��
�0����]Ff��ⲻn�'p���ib��}u#E8����:��X$i=
[�Aq�lL�gண���Y`�򅱾�na�X�2x� �<A~=@�%j������DO6;��k�ڍ��F��c,%�r��`5�����zB�@�uoy���F)�z�;�         O   x����0 �w�-к��"0��G�of�}�!�X(l�'��L%���M�%��rb��(}�/�ʽӽ*���: ��"�         �   x�e�KN�@  ���9��a�3ݙ&B�"X
��|��4%Z��m�z��td��I!"�A�*�r*%Z�5�F�ѿ]�:��b�w c.�$sd-�?��N׋�g3~㡒W�N�~He����<L���O�f����B*�8�I8CT�(FÐ`�Ͽ�H
o�s).���ۋ���j��픯+���V�ni&~9{�_����ñ�3�x�)c�`�/[�H"     