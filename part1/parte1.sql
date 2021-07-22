CREATE VIEW paradas AS
SELECT RT_ID, SN AS SB_B, STOP_CD AS STOP_CD_B, MAX(SN) AS SN_E, MAX(STOP_CD) AS STOP_CD_E, MAX(DIST) AS DIST
from pattern_detail
group by RT_ID
ORDER BY SN asc;