--- General point: Query syntax could be improved by proper indentation and spacing.
SELECT
	   RSEG.EBELN,
	   RSEG.EBELP,
       RSEG.BELNR,
       RSEG.AUGBL AS AUGBL_W,
       LPAD(EKPO.BSART,6,0) AS BSART, ---AS instead of as
	   BKPF.GJAHR,
	   BSEG.BUKRS,
	   BSEG.BUZEI,
	   BSEG.BSCHL,
	   BSEG.SHKZG,
       CASE
            WHEN BSEG.SHKZG = 'H' THEN (-1) * BSEG.DMBTR
            ELSE BSEG.DMBTR
       END AS DMBTR,
       COALESCE(BSEG.AUFNR, 'Kein SM-A Zuordnung') AS AUFNR,
       COALESCE(LFA1.LAND1, 'Andere') AS LAND1,
       LFA1.LIFNR,
       LFA1.ZSYSNAME,
       BKPF.BLART AS BLART, ---AS instead of as
       BKPF.BUDAT AS BUDAT, ---AS instead of as
       BKPF.CPUDT AS CPUDT  ---AS instead of as
  FROM "DTAG_DEV_CSBI_CELONIS_DATA"."dtag.dev.csbi.celonis.data.elog::V_RSEG" AS RSEG
  LEFT JOIN "DTAG_DEV_CSBI_CELONIS_WORK"."dtag.dev.csbi.celonis.app.p2p_elog::__P2P_REF_CASES" AS EKPO ON 1=1
   AND RSEG.ZSYSNAME = EKPO.SOURCE_SYSTEM
   AND RSEG.MANDT = EKPO.MANDT
   AND RSEG.EBELN || RSEG.EBELP = EKPO.EBELN || EKPO.EBELP
 INNER JOIN "DTAG_DEV_CSBI_CELONIS_DATA"."dtag.dev.csbi.celonis.data.elog::V_BKPF" AS BKPF ON 1=1
   AND BKPF.AWKEY = RSEG.AWKEY
   AND RSEG.ZSYSNAME = BKPF.ZSYSNAME
   AND RSEG.MANDT IN ('200') ---IN
 INNER JOIN "DTAG_DEV_CSBI_CELONIS_DATA"."dtag.dev.csbi.celonis.data.elog::V_BSEG" AS BSEG ON 1=1
   AND ISNULL(BSEG.ZFBDT) = 1 ---Invalid Function DATS_IS_VALID
   AND BSEG.KOART = 'K'
   AND CAST(BSEG.GJAHR AS INT) = 2020
   AND BKPF.ZSYSNAME = BSEG.ZSYSNAME
   AND BKPF.MANDT = BSEG.MANDT
   AND BKPF.BUKRS = BSEG.BUKRS
   AND BKPF.GJAHR = BSEG.GJAHR
   AND BKPF.BELNR = BSEG.BELNR
   AND BSEG.DMBTR*-1 >= 0
 INNER JOIN
       (SELECT *
          FROM "DTAG_DEV_CSBI_CELONIS_DATA"."dtag.dev.csbi.celonis.data.elog::V_LFA1" AS TEMP
         WHERE TEMP.LIFNR > '020000000') AS LFA1 ON 1=1
   AND BSEG.ZSYSNAME = LFA1.ZSYSNAME
   AND BSEG.LIFNR = LFA1.LIFNR
   AND BSEG.MANDT = LFA1.MANDT
   AND LFA1.LAND1 IN ('DE','SK') --- Specify fields in SELECT statement. Dont use *, IN instead of in
;