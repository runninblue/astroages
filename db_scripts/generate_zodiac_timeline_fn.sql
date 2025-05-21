-- FUNCTION: public.generate_zodiac_timeline(integer, integer, integer)

-- DROP FUNCTION IF EXISTS public.generate_zodiac_timeline(integer, integer, integer);

CREATE OR REPLACE FUNCTION public.generate_zodiac_timeline(
	start_year integer DEFAULT NULL::integer,
	end_year integer DEFAULT NULL::integer,
	step_years integer DEFAULT 1)
    RETURNS TABLE(zodiac_age text, color_hex text, period_start_year integer, period_end_year integer, duration_years integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
    actual_start INTEGER;
    actual_end INTEGER;
    current_year INTEGER;
    current_age_rec RECORD;
    prev_age TEXT := '';
    age_start INTEGER;
    age_years TEXT[];
BEGIN
	-- Set default values
	start_year := COALESCE(start_year, EXTRACT(YEAR FROM CURRENT_DATE)::INT);
	end_year := COALESCE(end_year, EXTRACT(YEAR FROM CURRENT_DATE)::INT);

	-- Normalize order
    actual_start := LEAST(start_year, end_year);
    actual_end := GREATEST(start_year, end_year);

    -- Process each year in the range
    FOR current_year IN actual_start..actual_end BY ABS(step_years) LOOP
        -- Get age info using explicit column aliases
        SELECT 
            ca.zodiac_age AS age_name,
            ca.color_hex AS hex_code
        INTO current_age_rec
        FROM calculate_astrological_age_for_year(current_year) ca;
        
        -- Track age transitions
        IF prev_age <> '' AND prev_age <> current_age_rec.age_name THEN
            -- Return previous age group
            duration_years := current_year - age_start;
            
            RETURN QUERY 
            SELECT 
                prev_age,
                z.color_hex,
                age_start,
                current_year - 1,
                duration_years
            FROM zodiac_signs z
            WHERE z.sign_name = prev_age;
                
            -- Reset for new age
            age_start := current_year;
            age_years := ARRAY[current_year::TEXT];
        ELSIF prev_age = '' THEN
            -- First iteration
            age_start := current_year;
            age_years := ARRAY[current_year::TEXT];
        ELSE
            -- Continue current age
            age_years := age_years || current_year::TEXT;
        END IF;
        
        prev_age := current_age_rec.age_name;
    END LOOP;
    
    -- Return the final age group
    IF prev_age <> '' THEN
        duration_years := actual_end - age_start + 1;
        
        RETURN QUERY 
        SELECT 
            prev_age,
            z.color_hex,
            age_start,
            actual_end,
            duration_years
        FROM zodiac_signs z
        WHERE z.sign_name = prev_age;
    END IF;
END;
$BODY$;
