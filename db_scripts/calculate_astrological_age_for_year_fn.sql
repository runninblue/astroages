-- FUNCTION: public.calculate_astrological_age_for_year(integer)

-- DROP FUNCTION IF EXISTS public.calculate_astrological_age_for_year(integer);

CREATE OR REPLACE FUNCTION public.calculate_astrological_age_for_year(
	input_year integer)
    RETURNS TABLE(zodiac_age text, age_start_year integer, age_end_year integer, years_into_age integer, years_remaining integer, percent_complete numeric, color_hex text, color_name text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
    platonic_year NUMERIC := 25771.5;
    precession_angle NUMERIC;
    current_sign_name TEXT;
    current_color_hex TEXT;
    current_color_name TEXT;
    sign_start_degree NUMERIC;
BEGIN
    -- Calculate current precession angle
    precession_angle := MOD(360.0 * (input_year / platonic_year), 360.0);
    IF precession_angle < 0 THEN 
        precession_angle := precession_angle + 360.0;
    END IF;
    
    -- Get sign details from table (using explicit column references)
    SELECT 
        z.sign_name, 
        z.color_hex, 
        z.color_name,
        z.start_degree
    INTO 
        current_sign_name,
        current_color_hex,
        current_color_name,
        sign_start_degree
    FROM zodiac_signs z
    WHERE precession_angle >= z.start_degree 
      AND precession_angle < z.end_degree;
    
    -- Calculate temporal metrics
    age_start_year := input_year - FLOOR(
        (precession_angle - sign_start_degree) * (platonic_year / 360.0)
    )::INTEGER;
    
    age_end_year := age_start_year + (platonic_year / 12.0)::INTEGER;
    years_into_age := input_year - age_start_year;
    years_remaining := age_end_year - input_year;
    percent_complete := (100.0 * years_into_age / (platonic_year / 12.0))::NUMERIC(5,2);
    
    -- Return all fields including colors
    zodiac_age := current_sign_name;
    color_hex := current_color_hex;
    color_name := current_color_name;
    
    RETURN NEXT;
END;
$BODY$;