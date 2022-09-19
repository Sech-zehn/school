#include <stdio.h>

const int volumeUnitaire = 8;

int main()
{
    float longueur, largeur, hauteur;
    printf("Longueur: ");
    scanf("%f", &longueur);
    printf("Largeur: ");
    scanf("%f", &largeur);
    printf("Hauteur: ");
    scanf("%f", &hauteur);

    float volume = longueur * largeur * hauteur;
    int quantite = volume / volumeUnitaire;

    printf("Quantité de radiateurs requise: %d", quantite);
    return 0;
}


=====

#include <stdio.h>

int main()
{
    float celsius, fahrenheit;
    printf("Température en °C: ");
    scanf("%f", &celsius);
    fahrenheit = (9.0/5.0) * celsius + 32;
    printf("En fahrenheit: %f", fahrenheit);
    return 0;
}

===

#include <stdio.h>

int main()
{
    int secondesinit, heures, minutes, secondes;
    printf("Secondes: ");
    scanf("%d", &secondesinit);
    
    heures = secondesinit / (60*60);
    minutes = (secondesinit - (heures * 60*60)) / 60;
    secondes = secondesinit%60;

    printf("%dh%d:%d", heures, minutes, secondes);
    return 0;
}

====


// TODO: réparer mdr


#include <stdio.h>
#include <math.h>

int main()
{
    float masse1, masse2, distance;
    printf("Masse 1: ");
    scanf("%f", &masse1);
    printf("Masse 2: ");
    scanf("%f", &masse2);
    printf("Distance: ");
    scanf("%f", &distance);
    float attraction = ((6.674*10E-11)*masse1*masse2)/pow(distance, 2);
    printf("Force: %f", attraction);
}

====

#include <stdio.h>
#include <math.h>

int main()
{
    int nombre;
    printf("Entier: ");
    scanf("%d", &nombre);
    if ((nombre%9) == 0)
    {
        printf("Divisible par 9");
    }
    else
    {
        printf("Pas divisible par 9");
    }
    return 0;
}

====

#include <stdio.h>
#include <math.h>
#include <stdbool.h>

int main()
{
    float a, b, c;
    bool isocele = false;
    bool equilateral = false;
    do
    {
        printf("Saisir A, B et C tels que A>B>C.\n");
        printf("A: ");
        scanf("%f", &a);
        printf("B: ");
        scanf("%f", &b);
        printf("C: ");
        scanf("%f", &c);
    } while (a > b || b > c);
    if (a + b > c)
    {
        if (a == b)
        {
            if (a == b && b == c)
            {
                equilateral = true;
            }
            else
            {
                isocele = true;
            }
        }
        if (a * a + b * b == c * c)
        {
            printf("Triangle rectangle ");
        }
        else
        {
            if (a * a + b * b < c)
            {
                printf("Triangle obtus ");
            }
            if (a * a + b * b > c)
            {
                printf("Triangle aigu ");
            }
            if (equilateral)
            {
                printf("triangle equilatateral");
            }
        }
        if (isocele)
        {
            printf("isocele");
        }
    }
    else
    {
        printf("Ceci n'est pas un triangle");
    }
    return 0;
}
