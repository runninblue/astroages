--
-- Data for Name: zodiac_signs; Type: TABLE DATA; Schema: public
--

INSERT INTO public.zodiac_signs (sign_id, sign_name, start_degree, end_degree, precessional_order, color_hex, color_name) VALUES (1, 'Pisces', 0.00, 30.00, 1, '#7799FF', 'Sea Blue');
INSERT INTO public.zodiac_signs (sign_id, sign_name, start_degree, end_degree, precessional_order, color_hex, color_name) VALUES (2, 'Aquarius', 30.00, 60.00, 2, '#33CCFF', 'Electric Blue');
INSERT INTO public.zodiac_signs (sign_id, sign_name, start_degree, end_degree, precessional_order, color_hex, color_name) VALUES (3, 'Capricorn', 60.00, 90.00, 3, '#666699', 'Deep Purple');
INSERT INTO public.zodiac_signs (sign_id, sign_name, start_degree, end_degree, precessional_order, color_hex, color_name) VALUES (4, 'Sagittarius', 90.00, 120.00, 4, '#FF9933', 'Fiery Orange');
INSERT INTO public.zodiac_signs (sign_id, sign_name, start_degree, end_degree, precessional_order, color_hex, color_name) VALUES (5, 'Scorpio', 120.00, 150.00, 5, '#990000', 'Dark Red');
INSERT INTO public.zodiac_signs (sign_id, sign_name, start_degree, end_degree, precessional_order, color_hex, color_name) VALUES (6, 'Libra', 150.00, 180.00, 6, '#FFCCFF', 'Pale Pink');
INSERT INTO public.zodiac_signs (sign_id, sign_name, start_degree, end_degree, precessional_order, color_hex, color_name) VALUES (7, 'Virgo', 180.00, 210.00, 7, '#FFFF99', 'Light Yellow');
INSERT INTO public.zodiac_signs (sign_id, sign_name, start_degree, end_degree, precessional_order, color_hex, color_name) VALUES (8, 'Leo', 210.00, 240.00, 8, '#FF6600', 'Bright Orange');
INSERT INTO public.zodiac_signs (sign_id, sign_name, start_degree, end_degree, precessional_order, color_hex, color_name) VALUES (9, 'Cancer', 240.00, 270.00, 9, '#FFFFFF', 'White');
INSERT INTO public.zodiac_signs (sign_id, sign_name, start_degree, end_degree, precessional_order, color_hex, color_name) VALUES (10, 'Gemini', 270.00, 300.00, 10, '#FFFF00', 'Yellow');
INSERT INTO public.zodiac_signs (sign_id, sign_name, start_degree, end_degree, precessional_order, color_hex, color_name) VALUES (11, 'Taurus', 300.00, 330.00, 11, '#00CC00', 'Green');
INSERT INTO public.zodiac_signs (sign_id, sign_name, start_degree, end_degree, precessional_order, color_hex, color_name) VALUES (12, 'Aries', 330.00, 360.00, 12, '#FF0000', 'Red');

SELECT pg_catalog.setval('public.zodiac_signs_sign_id_seq', 12, true);
