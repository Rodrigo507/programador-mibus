import csv


def readFile():
    with open('pattern_detail.csv') as csv_file:
        csvfile = csv.reader(csv_file, delimiter=',')
        all_value = []
        # skip header
        next(csvfile)
        for row in csvfile:
            value = (row[0], int(row[1]), row[2], row[6])
            all_value.append(value)
    return all_value


def stopDiff(rutas):
    allV = []
    rutas.sort()
    rt_id = rutas[0][0]
    dist_acum = 0
    lastStopCd = ""
    for p in rutas:
        dist = int(p[3])
        if rt_id != p[0]:
            rt_id = p[0]
            dist_acum = 0
            lastStopCd = ""
        diferencia = dist - dist_acum
        dist_acum = dist
        if diferencia != 0:
            allV.append([p[0], "{} - {}".format(lastStopCd, p[2]), diferencia])
        lastStopCd = p[2]
    return allV


def writeFile(paradas):
    header = ["RT_ID", "ARCO", "DISTANCIA"]

    file = open("diferenciaParadas.csv", "a", newline="")
    write = csv.writer(file)

    write.writerow(header)
    write.writerows(paradas)


if __name__ == "__main__":
    rutas = readFile()
    difereciaParadas = stopDiff(rutas)
    writeFile(difereciaParadas)
