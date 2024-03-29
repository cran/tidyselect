test_that("where() selects with a predicate", {
  expect_identical(select_loc(iris, where(is.factor)), c(Species = 5L))
  expect_identical(select_loc(iris, where(~ is.factor(.x))), c(Species = 5L))
})

test_that("where() checks return values", {
  expect_snapshot(error = TRUE, {
    where(NA)
  })

  expect_snapshot(error = TRUE, {
    select_loc(iris, where(~NA))
    select_loc(iris, where(~1))
    select_loc(iris, where(mean))
  })
})
