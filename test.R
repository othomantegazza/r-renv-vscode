1 + 1

library(magrittr)

library(tibble)
library(ggplot2)

mtcars %>%
  as_tibble() %>%
  ggplot(
    aes(
        x = mpg,
        y = hp
      )
  ) +
  geom_point()


