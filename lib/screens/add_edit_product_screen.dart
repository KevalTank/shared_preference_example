import 'package:demaze/bloc/product/product_bloc.dart';
import 'package:demaze/constants/status.dart';
import 'package:demaze/general/custom_button.dart';
import 'package:demaze/general/custom_text_form_field.dart';
import 'package:demaze/general/ui_utils.dart';
import 'package:demaze/general/un_focus_wrapper.dart';
import 'package:demaze/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AddEditProductScreen extends StatefulWidget {
  const AddEditProductScreen({
    Key? key,
    this.productModel,
  }) : super(key: key);

  final ProductModel? productModel;

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFields();
  }

  void _loadFields() {
    if (widget.productModel != null) {
      _productNameController.text = widget.productModel!.productName;
      _productDescriptionController.text =
          widget.productModel!.productDescription;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state.status == Status.success) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(widget.productModel != null ? 'EditProduct' : 'Add Product'),
        ),
        body: UnFocusWrapper(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            child: Column(
              children: [
                UiUtils.gap(),
                CustomTextFormField(
                  controller: _productNameController,
                  fieldTitle: 'Product Name',
                ),
                UiUtils.gap(),
                CustomTextFormField(
                  controller: _productDescriptionController,
                  fieldTitle: 'Product Description',
                  isProductDescriptionField: true,
                ),
                const Spacer(flex: 3),
                CustomButton(
                  onPressed: () {
                    if (widget.productModel != null) {
                      var newProductModel = ProductModel(
                        id: widget.productModel!.id,
                        productName: _productNameController.text.trim(),
                        productDescription:
                            _productDescriptionController.text.trim(),
                        createdTime: DateTime.now(),
                      );
                      context.read<ProductBloc>().add(
                            EditProductDetailsRequested(
                              productModel: newProductModel,
                            ),
                          );
                    } else {
                      context.read<ProductBloc>().add(
                            SaveProductDetailsRequested(
                              productName: _productNameController.text.trim(),
                              productDescription:
                                  _productDescriptionController.text.trim(),
                            ),
                          );
                    }
                  },
                  buttonText: widget.productModel != null ? 'Edit' : 'Add',
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
