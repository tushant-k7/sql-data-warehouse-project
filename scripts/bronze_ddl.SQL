CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;

bulk insert bronze.crm_cust_info
from 'C:\Users\hp\Desktop\sql warehouse\f78e076e5b83435d84c6b6af75d8a679 (1)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
set @end_time = getdate();
print '>>load duration:' + cast(datediff(second, @start_time, @end_time) as varchar) + 'seconds';
print '>>--------------';

SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		truncate table bronze.crm_prd_info;

bulk insert bronze.crm_prd_info
from 'C:\Users\hp\Desktop\sql warehouse\f78e076e5b83435d84c6b6af75d8a679 (1)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;

bulk insert bronze.crm_sales_details
from 'C:\Users\hp\Desktop\sql warehouse\f78e076e5b83435d84c6b6af75d8a679 (1)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

print '--------------------------------------------------';
print 'loading ERP Tables';
print'--------------------------------------------------';

SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
truncate table bronze.erp_cust_az12;

bulk insert bronze.erp_cust_az12
from 'C:\Users\hp\Desktop\sql warehouse\f78e076e5b83435d84c6b6af75d8a679 (1)\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
truncate table bronze.erp_loc_a101;
PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
bulk insert bronze.erp_loc_a101
from 'C:\Users\hp\Desktop\sql warehouse\f78e076e5b83435d84c6b6af75d8a679 (1)\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
truncate table bronze.erp_px_cat_g1v2;
PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
bulk insert bronze.erp_px_cat_g1v2
from 'C:\Users\hp\Desktop\sql warehouse\f78e076e5b83435d84c6b6af75d8a679 (1)\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
end try
begin catch
PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
end catch
end
