#include <stdio.h>
#include <stdlib.h>

int main() {
    int length = 0;
    int *nums = (int*) malloc(length * sizeof(int));

    while (1 == 1) {
        int n;
        printf("Enter the %dth number: ", length);
        scanf("%d", &n);
        if (n == 0)
        {
            break;
        }

        length++;

        /*
        // If memory allocation fails for some reason, it'll return a null pointer
        // It's recommended to check for it, but it's highly out of scope for this
        int *tmp = nums;
        nums = realloc(nums, length * sizeof(int));
        nums = tmp;
        */
        nums = realloc(nums, length * sizeof(int));

        nums[length - 1] = n;
    }

    int sum = 0;
    for (int i = 0; i < length; i++) {
        printf("%dth number: %d\n", i, nums[i]);
        sum += nums[i];
    }

    printf("Sum of the entered numbers: %d\n", sum);

    return 0;
}