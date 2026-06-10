test_that("beta_binomial_monitor works", {
  out <- beta_binomial_monitor(y = c(1, 2, 3), n = c(10, 10, 10))
  expect_s3_class(out, "data.frame")
  expect_equal(nrow(out), 3)
})

test_that("poisson_gamma_monitor works", {
  out <- poisson_gamma_monitor(y = c(1, 2, 3), exposure = c(10, 10, 10))
  expect_s3_class(out, "data.frame")
  expect_equal(nrow(out), 3)
})

test_that("simulate_surveillance_data works", {
  out <- simulate_surveillance_data(n_time = 10)
  expect_s3_class(out, "data.frame")
  expect_equal(nrow(out), 10)
})
