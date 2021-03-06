/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [PharmacyID]
      ,[fac_id]
	  , substring(dsps_dtm, 1,8) as dsps_dtm
	  ,substring(change_dtm,1,8) as change_dtm
	  ,count(*) as pack
	  , count(*) * 1.4 as estimated
into #temp100013  
  FROM ETL..[Dsps_medicine_history] (nolock)
  where dsps_dtm between '20200125000000' and '20200130000000'
  
  group by [PharmacyID]
      ,[fac_id], substring(dsps_dtm, 1,8), substring(change_dtm,1,8)

order by pharmacyID, fac_id, substring(dsps_dtm, 1,8), substring(change_dtm,1,8)

select *,sum(estimated) over (partition by fac_id order by dsps_dtm) as cum

from #temp100013
order by pharmacyID, fac_id

