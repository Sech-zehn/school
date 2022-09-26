```c title="exercice2-3.c"
#include <stdio.h>
#include <string.h>

int main()
{
    char nom[12][9] = {"Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"};
    int jour[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int numero;
    printf("Entrez un numero de mois compris entre 1 et 12: ");
    do
    {
        scanf("%d", &numero);
    } while (numero < 1 || numero > 12);
    numero -= 1;
    printf("Le mois que vous avez selectionne est %s. Il contient %d jours.", nom[numero], jour[numero]);
    return 0;
}
```

## TD 2

```c title="exercice1.c"
#include <stdio.h>

int main()
{
    int quantite;
    printf("Entrez la quantite de barres que vous voudriez voir: ");
    scanf("%d", &quantite);
    printf("Version 1: \n");
    for (int i = 0; i < quantite; i++)
    {
        printf("-");
    }
    printf("\nVersion 2: \n");
    for (int i = 0; i < quantite; i++)
    {
        printf("-");
    }
    printf("\n");
    for (int i = 0; i < quantite; i++)
    {
        printf("-");
    }
    printf("\nVersion 3: \n");
    for (int i = 0; i < quantite; i++)
    {
        printf("-\n");
    }
    return 0;
}
```

```c title="exercice2.c"
#include <stdio.h>

int main()
{
    int max;
    printf("Entrez la quantite: ");
    scanf("%d", &max);
    for (int i = 1; i <= max; i++)
    {
        for (int j = 1; j <= i; j++)
        {
            printf("%d", j);
        }
        printf("\n");
    }
    return 0;
}
```

```c title="exercice3.c"
#include <stdio.h>

int main()
{
    for (int i = 10; i <= 100; i++)
    {
        printf("%d: %d - %d\n", i, i * i, i * i * i);
    }
    return 0;
}
```

```c title="exercice4.c"
#include <stdio.h>

int main()
{
    int nombre;
    printf("Entrez n: ");
    scanf("%d", &nombre);
    if (nombre % 2)
    {
        printf("Ce nombre est impair.");
    }
    else
    {
        printf("Ce ombre est pair.");
    }
    return 0;
}
```

```c title="exercice5.c"
#include <stdio.h>
#include <math.h>

int main()
{
    float nombre;
    printf("Entrez un nombre: ");
    scanf("%f", &nombre);
    if (nombre < 0)
    {
        printf("Impossible de calcler la racine d'un nombre negatif.");
    }
    else
    {
        printf("La racine de %f est %f.", nombre, sqrt(nombre));
    }
    return 0;
}
```

```c title="exercice6.c"
#include <stdio.h>
#include <math.h>

int main()
{
    float x;
    int n;
    printf("Choisissez un nombre: ");
    scanf("%f", &x);
    printf("Choixissez un n: ");
    scanf("%d", &n);
    for (int i = 1; i <= n; i++)
    {
        float temp = pow(x, i);
        printf("%f ", temp);
    }
    return 0;
}
```

```c title="exercice7.c"
#include <stdio.h>

int main()
{
    float nombre;
    int n;
    float somme = 0;
    printf("Entrez un nombre: ");
    scanf("%f", &nombre);
    printf("Entrez n: ");
    scanf("%d", &n);
    for (int i = 1; i <= n; i++)
    {
        somme += nombre / (2 * i);
    }
    printf("La somme est: %f.", somme);
    return 0;
}
```

## TD3

```c title="exercice1.c"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

const float pi = 3.141592;

float aireCercle(float rayon)
{
    float aire = pi * pow(rayon, 2);
    return aire;
}

float circonferenceCercle(float rayon)
{
    float circonference = circonference = 2 * pi * rayon;
    return circonference;
}
float aireRectangle(float longueur, float largeur)
{
    float aire = longueur * largeur;
    return aire;
}

float circonferenceRectangle(float longueur, float largeur)
{
    float circonference = 2 * (longueur = largeur);
    return circonference;
}

int main(int argc, char **argv)
{
    float aire, circonference;
    if (argc == 2)
    {
        aire = aireCercle((atof(argv[1])));
        circonference = circonferenceCercle(atof(argv[1]));
    }
    else
    {
        aire = aireRectangle(atof(argv[1]), atof(argv[2]));
        circonference = circonferenceRectangle(atof(argv[1]), atof(argv[2]));
    }
    printf("Aire: %f\nCirconférence: %f", aire, circonference);
    return 0;
}
```

