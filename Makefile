MAKEFLAGS += --warn-undefined-variables
 
.PHONY: dev-build dev 

dev-build:
	docker compose build veridev

dev:
	docker compose up veridev

# delegation
DELEGATES = test_all test_alu test_rf context context_alu clean
.PHONY: $(DELEGATES)

$(DELEGATES):
	$(MAKE) -C src $@