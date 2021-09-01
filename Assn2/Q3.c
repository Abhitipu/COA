#include <stdio.h>

int main()
{
    int n,i=1,factors = 0;
    printf("Enter a positive number (greater than equal to 10): ");
    scanf("%d",&n);
    if(n<10)
    {
        printf("%d is less than 10\n", n);
        return 1;
    }
    while(i!=n)
    {
        if(n%i == 0)
        {
            factors++;
        }
        i++;
    }
    factors++; // n is always a factor of n
    if(factors == 2)
    {
        printf("%d is a prime number\n",n);
    }
    else
    {
        printf("%d is a composite number\n",n);
    }
    return 0;
}