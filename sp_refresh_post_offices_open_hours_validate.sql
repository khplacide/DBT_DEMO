-- =====================================================================
-- Stored Procedure: sp_refresh_post_offices_open_hours_validate
-- Schema: u610665
-- Description: Simplified validation procedure that checks if data 
--              was successfully loaded into open_hours_t table.
--              Returns 0 for success (row count > 0), 1 for failure.
-- =====================================================================
-- Return values:
--   0 = Validation passed (table has data)
--   1 = Validation failed (table is empty or error occurred)
-- =====================================================================

CREATE OR REPLACE FUNCTION u610665.sp_refresh_post_offices_open_hours_validate()
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_start_time        TIMESTAMP := NOW();
    v_step              VARCHAR(100);
    v_record_count      BIGINT;
BEGIN
    -- Log start
    RAISE NOTICE 'Starting VALIDATE procedure at %', v_start_time;
    
    -- Get record count from _T_ table
    v_step := 'Checking row count in open_hours_t';
    RAISE NOTICE 'Step 1: %', v_step;
    
    SELECT COUNT(*) INTO v_record_count
    FROM u610665.open_hours_t;
    
    RAISE NOTICE '  -> open_hours_t record count: %', v_record_count;
    
    -- Return based on row count
    IF v_record_count > 0 THEN
        RAISE NOTICE 'Validation PASSED - Row count is greater than 0';
        RAISE NOTICE 'Duration: % seconds', EXTRACT(EPOCH FROM (NOW() - v_start_time));
        RETURN 0;  -- Success
    ELSE
        RAISE WARNING 'Validation FAILED - open_hours_t is empty';
        RETURN 1;  -- Failure
    END IF;

EXCEPTION WHEN OTHERS THEN
    RAISE WARNING 'ERROR in VALIDATE procedure at step [%]: %', v_step, SQLERRM;
    RETURN 1;
END;
$$;

-- Grant execute permissions (optional - adjust based on your security requirements)
-- GRANT EXECUTE ON FUNCTION u610665.sp_refresh_post_offices_open_hours_validate() TO <role_name>;
