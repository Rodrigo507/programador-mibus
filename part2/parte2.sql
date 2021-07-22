-- 1.	¿Cuántas transacciones se realizan por cada hora? (mostrar las 24 horas)
CREATE VIEW transacciones_por_Hora AS
SELECT MAX(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:'))) as Hora, COUNT(Tarjeta) AS `Transacciones`
from transacciones
GROUP BY hour(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:')))
ORDER BY HOUR(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:')));
-- 3.	¿Cuántos buses operaron por cada hora?
CREATE VIEW cantidad_buses_por_hora AS
SELECT MAX(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:'))) AS Hora,
       COUNT(DISTINCT Bus)                                            AS `Cantidad de buses`
FROM transacciones
GROUP BY hour(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:')));
-- 4.	¿Cuáles son los 30 buses que más pasajeros transportaron?
CREATE VIEW busescon_mas_pasajeros AS
SELECT Bus, count(Tarjeta) as Pasajeros
from transacciones
group by Bus
order by count(Tarjeta) desc
limit 30;
-- 5.	¿Cuál fue el promedio de ingresos por hora?
CREATE VIEW promedio_ingreso_porhora AS
SELECT MAX(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:'))) as Hora,
       round(avg(`Tarifa-Monto`), 2)                                  AS `Ingreso promedio`
from transacciones
GROUP BY hour(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:')))
ORDER BY HOUR(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:')));
-- 6.	¿Qué buse fueron los que más ingresos generaron?
CREATE VIEW treinta_buses_con_mas_ingresos AS
SELECT Bus, round((sum(`Tarifa-Monto`) / 100), 2) as Ingresos
from transacciones
group by Bus
order by sum(`Tarifa-Monto`) desc
limit 30;
-- 7.	¿Cuáles fueron los ingresos durante el día en intervalos de quince minutos?
CREATE VIEW ingreso_intervalo_quince_minutos AS
SELECT MAX(SEC_TO_TIME(TIME_TO_SEC(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:'))) -
                       TIME_TO_SEC(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:')) % (15 * 60)))) as Hora,
       round((SUM(`Tarifa-Monto`) / 100), 2)                                                                AS `Ingresos`
from transacciones
GROUP BY SEC_TO_TIME(TIME_TO_SEC(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:'))) -
                     TIME_TO_SEC(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:')) % (15 * 60)))
ORDER BY SEC_TO_TIME(TIME_TO_SEC(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:'))) -
                     TIME_TO_SEC(TIME(STR_TO_DATE(`Fecha Transaccion`, '%m/%d/%Y %k:%i:')) % (15 * 60)))

