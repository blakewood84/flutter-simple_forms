# simple_forms

Simple Forms is aimed to make forms Simpler!

### How to Use

1. First, create a new form state and supply the types needed for your Map, which holds the contents of your form data.

<p align="center"><img src="/images/1.png" alt="1" /></p>

2. Second, instantiate your new `Form State` into the widget you will use for your Form.

<p align="center"><img src="/images/2.png" alt="2" /></p>

3. Third, add your new `Form State` into then `FormInput` **Widget** and provide it the key that you will use with your form state. This widget will only rebuild when that value for that specific key has changed. You can call changes like so: `_formState['email'] = 'test@test.com'`, or to not rebuild and only update the form itself `_formState.updateFormOnly('email', 'test@test.com')`.

<p align="center"><img src="/images/3.png" alt="3" /></p>

<p align="center"><img src="/images/4.png" alt="4" /></p>
